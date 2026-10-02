import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/cash_list_provider.dart';
import 'package:titan/amap/providers/delivery_order_list_provider.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class DetailOrderUI extends HookConsumerWidget {
  final Order order;
  final Cash userCash;
  final String deliveryId;
  const DetailOrderUI({
    super.key,
    required this.order,
    required this.userCash,
    required this.deliveryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderList = ref.watch(userOrderListProvider);
    final orderListNotifier = ref.watch(userOrderListProvider.notifier);
    final deliveryOrdersNotifier = ref.watch(
      adminDeliveryOrderListProvider.notifier,
    );
    final cashListNotifier = ref.watch(cashListProvider.notifier);
    final isDarkTheme = ref.watch(themeProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      width: 250,
      height: 139 + (24.0 * order.products.length),
      colors: [
        AMAPColors(isDarkTheme).lightGradientPrimary,
        AMAPColors(isDarkTheme).lightGradientSecondary,
      ],
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 216,
            child: AutoSizeText(
              order.user.getName(),
              maxLines: 1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AMAPColors(isDarkTheme).secondaryGreen,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...order.products.map(
            (product) => Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    product.name,
                    maxLines: 1,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AMAPColors(isDarkTheme).primaryGreen,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    "${product.quantity} (${((product.quantity * product.price) / 100).toStringAsFixed(2)}€)",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AMAPColors(isDarkTheme).primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: AMAPColors(isDarkTheme).primaryGreen,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            margin: const EdgeInsets.symmetric(vertical: 7),
          ),
          Row(
            children: [
              Text(
                "${order.products.fold<int>(0, (value, product) => value + product.quantity)} ${AMAPTextConstants.product}${order.products.fold<int>(0, (value, product) => value + product.quantity) != 1 ? "s" : ""}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AMAPColors(isDarkTheme).primaryGreen,
                ),
              ),
              const Spacer(),
              Text(
                "${(order.amount / 100).toStringAsFixed(2)}€",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AMAPColors(isDarkTheme).primaryGreen,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                "${AMAPTextConstants.amount} : ${(userCash.balance / 100).toStringAsFixed(2)}€",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AMAPColors(isDarkTheme).secondaryGreen,
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
                          final index = orderList.maybeWhen(
                            data: (data) => data.indexWhere(
                              (element) => element.id == order.id,
                            ),
                            orElse: () => -1,
                          );
                          await orderListNotifier.deleteOrder(order).then((
                            value,
                          ) {
                            if (value) {
                              if (index != -1) {
                                deliveryOrdersNotifier.deleteE(
                                  deliveryId,
                                  index,
                                );
                              }
                              cashListNotifier.fakeUpdateCash(
                                userCash.copyWith(
                                  balance: userCash.balance + order.amount,
                                ),
                              );
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
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
