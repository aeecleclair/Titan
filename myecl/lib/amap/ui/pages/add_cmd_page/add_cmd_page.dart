import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/add_cmd_page/product_ui_check.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class AddCmdPage extends HookConsumerWidget {
  const AddCmdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final dateController = useTextEditingController();
    final productsList = ref.watch(productListProvider);
    final deliveryNotifier = ref.watch(deliveryListProvider.notifier);
    final List<Product> products = [];
    final categories = [];

    productsList.when(
      data: (list) => products.addAll(list),
      error: (e, s) {},
      loading: () {},
    );

    final selected = ref.watch(selectedListProvider);
    final selectedNotifier = ref.watch(selectedListProvider.notifier);

    products.map((e) {
      if (!categories.contains(e.category)) {
        categories.add(e.category);
      }
    }).toList();

    Map<String, List<Widget>> dictCateListWidget = {
      for (var item in categories) item: []
    };

    for (Product p in products) {
      var i = products.indexOf(p);
      dictCateListWidget[p.category]!.add(ProductUi(
          p: p,
          i: i,
          isModif: selected[i],
          onclick: (value) => selectedNotifier.toggle(i)));
    }

    List<Widget> listWidget = [];

    for (String c in categories) {
      listWidget.add(Container(
          height: 70,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              c,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          )));

      listWidget += dictCateListWidget[c] ?? [];
    }

    return Column(children: [
      const SizedBox(
        height: 60,
      ),
      Expanded(
          child: Container(
        decoration: BoxDecoration(
            color: AMAPColorConstants.background2.withOpacity(0.5)),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(bottom: 3),
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        AMAPTextConstants.commandDate,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 85, 85, 85),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          _selectDate(context, dateController),
                                      child: SizedBox(
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            controller: dateController,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              isDense: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              85,
                                                              85,
                                                              85))),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.blue)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 158, 158, 158),
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AMAPTextConstants
                                                    .requiredDate;
                                              }
                                              return null;
                                            },
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            AMAPTextConstants.commandProducts,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...listWidget,
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                              child: const GreenBtn(
                                  text: AMAPTextConstants.addingCommand),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final date = dateController.value.text;
                                  final del = Delivery(
                                      id: "",
                                      products: products
                                          .where((element) => selected[
                                              products.indexOf(element)])
                                          .toList(),
                                      deliveryDate: DateTime.parse(date),
                                      locked: false);
                                  tokenExpireWrapper(ref, () async {
                                    final value =
                                        await deliveryNotifier.addDelivery(del);
                                    if (value) {
                                      pageNotifier.setAmapPage(AmapPage.admin);
                                      displayAMAPToast(context, TypeMsg.msg,
                                          AMAPTextConstants.addedCommand);
                                    } else {
                                      displayAMAPToast(
                                          context,
                                          TypeMsg.error,
                                          AMAPTextConstants
                                              .alreadyExistCommand);
                                    }
                                    selectedNotifier.clear();
                                  });
                                } else {
                                  displayAMAPToast(context, TypeMsg.error,
                                      AMAPTextConstants.addingError);
                                }
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                        ]))))),
      ))
    ]);
  }

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    dateController.text = DateFormat('yyyy-MM-dd').format(picked ?? now);
  }
}
