import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/providers/sorted_by_category_products.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/amap/ui/pages/delivery_pages/product_ui_check.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/date_entry.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditDeliveryPage extends HookConsumerWidget {
  const AddEditDeliveryPage({super.key});

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
                              child: DateEntry(
                                onTap: () =>
                                    getOnlyDayDate(context, dateController),
                                label: AMAPTextConstants.commandDate,
                                controller: dateController,
                                enabledColor: AMAPColorConstants.enabled,
                                color: AMAPColorConstants.greenGradient2,
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
                                                                isModification:
                                                                    selected[products
                                                                        .indexOf(
                                                                            e)],
                                                                onclick: () {
                                                                  selectedNotifier
                                                                      .toggle(products
                                                                          .indexOf(
                                                                              e));
                                                                },
                                                                product: e,
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
                                        builder: (child) => AddEditButtonLayout(
                                            color: AMAPColorConstants
                                                .greenGradient1,
                                            gradient: AMAPColorConstants
                                                .greenGradient2,
                                            child: child),
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            final date =
                                                dateController.value.text;
                                            final del = Delivery(
                                                id: isEdit ? delivery.id : '',
                                                products: products
                                                    .where((element) =>
                                                        selected[products
                                                            .indexOf(element)])
                                                    .toList(),
                                                deliveryDate: DateTime.parse(
                                                    processDateBack(date)),
                                                status:
                                                    DeliveryStatus.creation);
                                            await tokenExpireWrapper(ref,
                                                () async {
                                              final deliveryNotifier =
                                                  ref.watch(deliveryListProvider
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
                                                    deliveryOrdersNotifier.addT(
                                                        deliveries.last.id);
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
                                            displayToast(context, TypeMsg.error,
                                                AMAPTextConstants.addingError);
                                          }
                                        },
                                        child: Text(
                                          isEdit
                                              ? AMAPTextConstants.editDelivery
                                              : AMAPTextConstants.addDelivery,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: AMAPColorConstants
                                                  .background),
                                        ),
                                      ),
                                    ],
                                  ),
                              error: (Object error, StackTrace stackTrace) =>
                                  const Text('error'),
                              loading: () => const Loader(
                                  color: AMAPColorConstants.greenGradient2)),
                          const SizedBox(height: 40),
                        ]))))),
      ),
    );
  }
}
