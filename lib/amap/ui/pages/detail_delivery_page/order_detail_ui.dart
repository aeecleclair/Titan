import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/amap/providers/cash_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class DetailOrderUI extends HookConsumerWidget {
  final OrderReturn order;
  final AppSchemasSchemasAmapCashComplete userCash;
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
    final deliveryOrdersNotifier =
        ref.watch(adminDeliveryOrderListProvider.notifier);
    final cashListNotifier = ref.watch(cashListProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      width: 250,
      height: 145 + (20.0 * order.productsdetail.length),
      colors: const [
        AMAPColorConstants.lightGradient1,
        AMAPColorConstants.greenGradient1
      ],
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 216,
            child: AutoSizeText(getName(order.user),
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.textDark)),
          ),
          const SizedBox(height: 10),
          ...order.productsdetail.map(
            (productQuantity) => Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    productQuantity.product.name,
                    maxLines: 1,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    "${productQuantity.quantity} (${(productQuantity.quantity * productQuantity.product.price).toStringAsFixed(2)}€)",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 3,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.symmetric(vertical: 7)),
          Row(
            children: [
              Text(
                "${order.productsdetail.fold<int>(0, (value, productQuantity) => value + productQuantity.quantity)} ${AMAPTextConstants.product}${order.productsdetail.fold<int>(0, (value, productQuantity) => value + productQuantity.quantity) != 1 ? "s" : ""}",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const Spacer(),
              Text(
                "${order.amount.toStringAsFixed(2)}€",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                "${AMAPTextConstants.amount} : ${userCash.balance.toStringAsFixed(2)}€",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AMAPColorConstants.textDark),
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
                                  data: (data) => data.indexWhere((element) =>
                                      element.orderId == order.orderId),
                                  orElse: () => -1);
                              await orderListNotifier
                                  .deleteOrder(order)
                                  .then((value) {
                                if (value) {
                                  if (index != -1) {
                                    deliveryOrdersNotifier.deleteE(
                                        deliveryId, index);
                                  }
                                  cashListNotifier.loadCashList();
                                  displayToastWithContext(TypeMsg.msg,
                                      AMAPTextConstants.deletedOrder);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      AMAPTextConstants.deletingError);
                                }
                              });
                            });
                          })));
                },
                builder: (child) => CardButton(colors: const [
                  AMAPColorConstants.redGradient1,
                  AMAPColorConstants.redGradient2
                ], child: child),
                child: const HeroIcon(
                  HeroIcons.trash,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
