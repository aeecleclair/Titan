import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/providers/delivery_order_list_provider.dart';
import 'package:titan/amap/providers/delivery_provider.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/amap/providers/selected_list_provider.dart';
import 'package:titan/amap/providers/sorted_by_category_products.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/amap.dart';
import 'package:titan/amap/ui/pages/delivery_pages/product_ui_check.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditDeliveryPage extends HookConsumerWidget {
  const AddEditDeliveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final formKey = GlobalKey<FormState>();
    final delivery = ref.watch(deliveryProvider);
    final isEdit = delivery.id != Delivery.empty().id;
    final dateController = useTextEditingController(
      text: isEdit ? DateFormat.yMd(locale).format(delivery.deliveryDate) : '',
    );
    final nameController = useTextEditingController();
    final productList = ref.watch(productListProvider);
    final sortedProductsList = ref.watch(sortedByCategoryProductsProvider);
    final selected = ref.watch(selectedListProvider);
    final selectedNotifier = ref.watch(selectedListProvider.notifier);
    final deliveryNotifier = ref.watch(deliveryListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;
    final scrollController = useScrollController();

    return AmapTemplate(
      child: ScrollToHideNavbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      AlignLeftText(
                        AppLocalizations.of(context)!.amapAddDelivery,
                        color: AMAPColorConstants.green2,
                      ),
                      const SizedBox(height: 20),
                      TextEntry(
                        label: AppLocalizations.of(context)!.amapCommandName,
                        controller: nameController,
                        color: AMAPColorConstants.greenGradient2,
                        enabledColor: AMAPColorConstants.enabled,
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: DateEntry(
                          onTap: () => getOnlyDayDate(context, dateController),
                          label: AppLocalizations.of(context)!.amapCommandDate,
                          controller: dateController,
                          enabledColor: AMAPColorConstants.enabled,
                          color: AMAPColorConstants.greenGradient2,
                        ),
                      ),
                      const SizedBox(height: 15),
                      AlignLeftText(
                        AppLocalizations.of(context)!.amapCommandProducts,
                        fontSize: 25,
                      ),
                      const SizedBox(height: 35),
                      AsyncChild(
                        value: productList,
                        builder: (context, products) => Column(
                          children: [
                            if (products.isNotEmpty)
                              Column(
                                children: sortedProductsList
                                    .map(
                                      (key, value) => MapEntry(
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
                                                  color: Color.fromARGB(
                                                    0,
                                                    255,
                                                    0,
                                                    0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ...value.map(
                                              (e) => ProductUi(
                                                isModification:
                                                    selected[products.indexOf(
                                                      e,
                                                    )],
                                                onclick: () {
                                                  selectedNotifier.toggle(
                                                    products.indexOf(e),
                                                  );
                                                },
                                                product: e,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    )
                                    .values
                                    .toList(),
                              ),
                            const SizedBox(height: 30),
                            WaitingButton(
                              builder: (child) => AddEditButtonLayout(
                                colors: const [
                                  AMAPColorConstants.greenGradient1,
                                  AMAPColorConstants.greenGradient2,
                                ],
                                child: child,
                              ),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  final date = dateController.value.text;
                                  final del = Delivery(
                                    name: nameController.text,
                                    id: isEdit ? delivery.id : '',
                                    products: products
                                        .where(
                                          (element) =>
                                              selected[products.indexOf(
                                                element,
                                              )],
                                        )
                                        .toList(),
                                    deliveryDate: DateTime.parse(
                                      processDateBack(date, locale.toString()),
                                    ),
                                    status: DeliveryStatus.creation,
                                  );
                                  await tokenExpireWrapper(ref, () async {
                                    final value = isEdit
                                        ? await deliveryNotifier.updateDelivery(
                                            del,
                                          )
                                        : await deliveryNotifier.addDelivery(
                                            del,
                                          );
                                    if (value) {
                                      QR.back();
                                      if (isEdit) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          localizeWithContext.amapEditedCommand,
                                        );
                                      } else {
                                        final deliveryOrdersNotifier = ref
                                            .watch(
                                              adminDeliveryOrderListProvider
                                                  .notifier,
                                            );
                                        final deliveryList = ref.watch(
                                          deliveryListProvider,
                                        );
                                        deliveryList.whenData((deliveries) {
                                          deliveryOrdersNotifier.addT(
                                            deliveries.last.id,
                                          );
                                        });
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          localizeWithContext.amapAddedCommand,
                                        );
                                      }
                                    } else {
                                      if (isEdit) {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          localizeWithContext.amapEditingError,
                                        );
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          localizeWithContext.amapAddingError,
                                        );
                                      }
                                    }
                                  });
                                } else {
                                  displayToast(
                                    context,
                                    TypeMsg.error,
                                    localizeWithContext
                                        .amapIncorrectlyFilledForm,
                                  );
                                }
                              },
                              child: Text(
                                isEdit
                                    ? AppLocalizations.of(
                                        context,
                                      )!.amapEditDelivery
                                    : AppLocalizations.of(
                                        context,
                                      )!.amapAddDelivery,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AMAPColorConstants.background,
                                ),
                              ),
                            ),
                          ],
                        ),
                        loaderColor: AMAPColorConstants.greenGradient2,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
