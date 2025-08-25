import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/user_amount_provider.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/tools/functions.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/l10n/app_localizations.dart';

class OrderUI extends HookConsumerWidget {
  final Order order;
  final void Function()? onTap, onEdit;
  final bool showButton, isDetail;
  const OrderUI({
    super.key,
    required this.order,
    this.onTap,
    this.onEdit,
    this.showButton = true,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final orderListNotifier = ref.watch(userOrderListProvider.notifier);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final balanceNotifier = ref.watch(userAmountProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      id: order.id,
      width: 195,
      height: isDetail ? 100 : 150,
      colors: const [
        AMAPColorConstants.lightGradient1,
        AMAPColorConstants.greenGradient1,
      ],
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocalizations.of(context)!.amapThe} ${DateFormat.yMd(locale).format(order.deliveryDate)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AMAPColorConstants.textDark,
                ),
              ),
              if (!isDetail)
                GestureDetector(
                  onTap: () {
                    orderNotifier.setOrder(order);
                    onTap?.call();
                  },
                  child: const HeroIcon(
                    HeroIcons.informationCircle,
                    color: AMAPColorConstants.textDark,
                    size: 30,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                "${order.products.length} ${AppLocalizations.of(context)!.amapProduct}${order.products.length != 1 ? "s" : ""}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "${order.amount.toStringAsFixed(2)}€",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            uiCollectionSlotToString(order.collectionSlot, context),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AMAPColorConstants.textDark,
            ),
          ),
          const Spacer(),
          if (!isDetail)
            showButton
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          orderNotifier.setOrder(order);
                          onEdit?.call();
                        },
                        child: const CardButton(
                          colors: [
                            AMAPColorConstants.greenGradient1,
                            AMAPColorConstants.greenGradient2,
                          ],
                          child: HeroIcon(
                            HeroIcons.pencil,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      WaitingButton(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: ((context) => CustomDialogBox(
                              title: AppLocalizations.of(context)!.amapDelete,
                              descriptions: AppLocalizations.of(
                                context,
                              )!.amapDeletingOrder,
                              onYes: () async {
                                final deletedOrderMsg = AppLocalizations.of(
                                  context,
                                )!.amapDeletedOrder;
                                final deletingErrorMsg = AppLocalizations.of(
                                  context,
                                )!.amapDeletingError;
                                await tokenExpireWrapper(ref, () async {
                                  orderListNotifier.deleteOrder(order).then((
                                    value,
                                  ) {
                                    if (value) {
                                      balanceNotifier.updateCash(order.amount);
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        deletedOrderMsg,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        deletingErrorMsg,
                                      );
                                    }
                                  });
                                });
                              },
                            )),
                          );
                        },
                        builder: (child) => CardButton(
                          colors: const [
                            AMAPColorConstants.redGradient1,
                            AMAPColorConstants.redGradient2,
                          ],
                          child: child,
                        ),
                        child: const HeroIcon(
                          HeroIcons.trash,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : Text(
                    AppLocalizations.of(context)!.amapLocked,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AMAPColorConstants.textDark,
                    ),
                  ),
        ],
      ),
    );
  }
}
