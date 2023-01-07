import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/sorted_by_category_products.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/delivery_pages/product_ui_check.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AddEditDeliveryPage extends HookConsumerWidget {
  const AddEditDeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final dateController = useTextEditingController();
    final products = ref.watch(productList);
    final sortedProductsList = ref.watch(sortedByCategoryProductsProvider);
    final deliveryNotifier = ref.watch(deliveryListProvider.notifier);
    final selected = useState(List.generate(products.length, (index) => true));

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AMAPTextConstants.addDelivery,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: AMAPColorConstants.green2,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            child: GestureDetector(
                              onTap: () => _selectDate(context, dateController),
                              child: SizedBox(
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      hintText: AMAPTextConstants.commandDate,
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 85, 85, 85),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AMAPColorConstants.enabled)),
                                      errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 201, 23, 23))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color:
                                            AMAPColorConstants.greenGradient2,
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AMAPTextConstants.requiredDate;
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AMAPTextConstants.commandProducts,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (products.isNotEmpty)
                          Column(
                            children: sortedProductsList
                                .map((key, value) => MapEntry(
                                    key,
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            key,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ...value.map((e) => ProductUi(
                                              isModif: selected
                                                  .value[products.indexOf(e)],
                                              onclick: () {
                                                selected.value[
                                                    products
                                                        .indexOf(e)] = !selected
                                                    .value[products.indexOf(e)];
                                              },
                                              p: e,
                                            ))
                                      ],
                                    )))
                                .values
                                .toList(),
                          ),
                        const SizedBox(
                          height: 30,
                        ),
                        ShrinkButton(
                            child: const GreenBtn(
                                text: AMAPTextConstants.addDelivery),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                final date = dateController.value.text;
                                final del = Delivery(
                                    id: "",
                                    products: products
                                        .where((element) => selected
                                            .value[products.indexOf(element)])
                                        .toList(),
                                    deliveryDate:
                                        DateTime.parse(processDateBack(date)),
                                    locked: false);
                                tokenExpireWrapper(ref, () async {
                                  final value =
                                      await deliveryNotifier.addDelivery(del);
                                  if (value) {
                                    pageNotifier.setAmapPage(AmapPage.admin);
                                    displayToastWithContext(TypeMsg.msg,
                                        AMAPTextConstants.addedCommand);
                                  } else {
                                    displayToastWithContext(TypeMsg.error,
                                        AMAPTextConstants.alreadyExistCommand);
                                  }
                                });
                              } else {
                                displayToast(context, TypeMsg.error,
                                    AMAPTextConstants.addingError);
                              }
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                      ]))))),
    );
  }

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    dateController.text = DateFormat('dd/MM/yyyy').format(picked ?? now);
  }
}
