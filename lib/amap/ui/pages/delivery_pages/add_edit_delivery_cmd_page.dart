import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/providers/sorted_by_category_products.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/delivery_pages/product_ui_check.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditDeliveryPage extends HookConsumerWidget {
  const AddEditDeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final delivery = ref.watch(deliveryProvider);
    final isEdit = delivery.id != Delivery.empty().id;
    final dateController = useTextEditingController(
        text: isEdit ? processDate(delivery.deliveryDate) : '');
    final productList = ref.watch(productListProvider);
    final sortedProductsList = ref.watch(sortedByCategoryProductsProvider);
    final selected = ref.watch(selectedListProvider);
    final selectedNotifier = ref.watch(selectedListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AmapTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
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
                                onTap: () =>
                                    _selectDate(context, dateController),
                                child: SizedBox(
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: dateController,
                                      decoration: const InputDecoration(
                                        hintText: AMAPTextConstants.commandDate,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 85, 85, 85),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AMAPColorConstants
                                                    .enabled)),
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
                            height: 15,
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
                            height: 35,
                          ),
                          productList.when(
                              data: (products) => Column(
                                    children: [
                                      if (products.isNotEmpty)
                                        Column(
                                          children: sortedProductsList
                                              .map((key, value) => MapEntry(
                                                  key,
                                                  Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          key,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      ...value
                                                          .map((e) => ProductUi(
                                                                isModif: selected[
                                                                    products
                                                                        .indexOf(
                                                                            e)],
                                                                onclick: () {
                                                                  selectedNotifier
                                                                      .toggle(products
                                                                          .indexOf(
                                                                              e));
                                                                },
                                                                p: e,
                                                              )),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  )))
                                              .values
                                              .toList(),
                                        ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ShrinkButton(
                                          waitChild: const GreenBtn(
                                              text: AMAPTextConstants.waiting),
                                          onTap: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              final date =
                                                  dateController.value.text;
                                              final del = Delivery(
                                                  id: isEdit ? delivery.id : '',
                                                  products: products
                                                      .where((element) =>
                                                          selected[
                                                              products.indexOf(
                                                                  element)])
                                                      .toList(),
                                                  deliveryDate: DateTime.parse(
                                                      processDateBack(date)),
                                                  status:
                                                      DeliveryStatus.creation);
                                              await tokenExpireWrapper(ref,
                                                  () async {
                                                final deliveryNotifier = ref
                                                    .watch(deliveryListProvider
                                                        .notifier);
                                                final value = isEdit
                                                    ? await deliveryNotifier
                                                        .updateDelivery(del)
                                                    : await deliveryNotifier
                                                        .addDelivery(del);
                                                if (value) {
                                                  QR.back();
                                                  if (isEdit) {
                                                    displayToastWithContext(
                                                        TypeMsg.msg,
                                                        AMAPTextConstants
                                                            .editedCommand);
                                                  } else {
                                                    final deliveryOrdersNotifier =
                                                        ref.watch(
                                                            adminDeliveryOrderListProvider
                                                                .notifier);
                                                    final deliveryList =
                                                        ref.watch(
                                                            deliveryListProvider);
                                                    deliveryList
                                                        .whenData((deliveries) {
                                                      deliveryOrdersNotifier
                                                          .addT(deliveries
                                                              .last.id);
                                                    });
                                                    displayToastWithContext(
                                                        TypeMsg.msg,
                                                        AMAPTextConstants
                                                            .addedCommand);
                                                  }
                                                } else {
                                                  if (isEdit) {
                                                    displayToastWithContext(
                                                        TypeMsg.error,
                                                        AMAPTextConstants
                                                            .editingError);
                                                  } else {
                                                    displayToastWithContext(
                                                        TypeMsg.error,
                                                        AMAPTextConstants
                                                            .alreadyExistCommand);
                                                  }
                                                }
                                              });
                                            } else {
                                              displayToast(
                                                  context,
                                                  TypeMsg.error,
                                                  AMAPTextConstants
                                                      .addingError);
                                            }
                                          },
                                          child: GreenBtn(
                                              text: isEdit
                                                  ? AMAPTextConstants
                                                      .editDelivery
                                                  : AMAPTextConstants
                                                      .addDelivery)),
                                    ],
                                  ),
                              error: (Object error, StackTrace stackTrace) {
                                return const Text('error');
                              },
                              loading: () {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AMAPColorConstants.greenGradient2,
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                        ]))))),
      ),
    );
  }

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        locale: const Locale("fr", "FR"),
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    dateController.text = DateFormat('dd/MM/yyyy').format(picked ?? now);
  }
}
