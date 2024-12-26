import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/providers/theme_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

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
    final orderListNotifier = ref.watch(userOrderListProvider.notifier);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final balanceNotifier = ref.watch(userAmountProvider.notifier);
    final isDarkTheme = ref.watch(themeProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      id: order.id,
      width: 195,
      height: isDetail ? 100 : 150,
      colors: [
        AMAPColors(isDarkTheme).lightGradientPrimary,
        AMAPColors(isDarkTheme).greenGradientPrimary,
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
                '${AMAPTextConstants.the} ${processDate(order.deliveryDate)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AMAPColors(isDarkTheme).textOnPrimary,
                ),
              ),
              if (!isDetail)
                GestureDetector(
                  onTap: () {
                    orderNotifier.setOrder(order);
                    onTap?.call();
                  },
                  child: HeroIcon(
                    HeroIcons.informationCircle,
                    color: AMAPColors(isDarkTheme).textOnPrimary,
                    size: 30,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                "${order.products.length} ${AMAPTextConstants.product}${order.products.length != 1 ? "s" : ""}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              const Spacer(),
              Text(
                "${order.amount.toStringAsFixed(2)}€",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            uiCollectionSlotToString(order.collectionSlot),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AMAPColors(isDarkTheme).textOnPrimary,
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
                        child: CardButton(
                          colors: [
                            AMAPColors(isDarkTheme).greenGradientPrimary,
                            AMAPColors(isDarkTheme).greenGradientSecondary,
                          ],
                          child: HeroIcon(
                            HeroIcons.pencil,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      WaitingButton(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: ((context) => CustomDialogBox(
                                  title: AMAPTextConstants.delete,
                                  descriptions: AMAPTextConstants.deletingOrder,
                                  onYes: () async {
                                    await tokenExpireWrapper(ref, () async {
                                      orderListNotifier
                                          .deleteOrder(order)
                                          .then((value) {
                                        if (value) {
                                          balanceNotifier
                                              .updateCash(order.amount);
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            AMAPTextConstants.deletedOrder,
                                          );
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            AMAPTextConstants.deletingError,
                                          );
                                        }
                                      });
                                    });
                                  },
                                )),
                          );
                        },
                        builder: (child) => CardButton(
                          colors: [
                            AMAPColors(isDarkTheme).redGradientPrimary,
                            AMAPColors(isDarkTheme).redGradientSecondary,
                          ],
                          child: child,
                        ),
                        child: HeroIcon(
                          HeroIcons.trash,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  )
                : Text(
                    AMAPTextConstants.locked,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AMAPColors(isDarkTheme).textOnPrimary,
                    ),
                  ),
        ],
      ),
    );
  }
}
