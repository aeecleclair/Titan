import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

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
    final orderListNotifier = ref.watch(userOrderListProvider.notifier);
    final deliveryOrdersNotifier =
        ref.watch(adminDeliveryOrderListProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      margin: const EdgeInsets.only(left: 15.0, bottom: 35.0, right: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17.0),
      width: 250,
      height: 145 + (20.0 * order.products.length),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const RadialGradient(
          colors: [
            Color.fromARGB(223, 182, 212, 10),
            AMAPColorConstants.greenGradient1,
          ],
          center: Alignment.topLeft,
          radius: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: AMAPColorConstants.greenGradient2.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 216,
            child: AutoSizeText(order.user.getName(),
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.textDark)),
          ),
          const SizedBox(height: 10),
          ...order.products.map(
            (product) => Row(
              children: [
                AutoSizeText(
                  product.name,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "${product.quantity} (${(product.quantity * product.price).toStringAsFixed(2)}€)",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
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
                "${order.products.length} ${AMAPTextConstants.product}${order.products.length != 1 ? "s" : ""}",
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
              ShrinkButton(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: ((context) => CustomDialogBox(
                          title: AMAPTextConstants.delete,
                          descriptions: AMAPTextConstants.deletingOrder,
                          onYes: () async {
                            await tokenExpireWrapper(ref, () async {
                              await orderListNotifier
                                  .deleteOrder(order)
                                  .then((value) {
                                if (value) {
                                  orderListNotifier.copy().then((value) {
                                    print(value);
                                    deliveryOrdersNotifier.setTData(
                                        deliveryId, value);
                                  });
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
                waitChild: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AMAPColorConstants.redGradient1,
                          AMAPColorConstants.redGradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: AMAPColorConstants.redGradient2
                                .withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AMAPColorConstants.redGradient1,
                        AMAPColorConstants.redGradient2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color:
                              AMAPColorConstants.redGradient2.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(2, 3))
                    ],
                  ),
                  child: const HeroIcon(
                    HeroIcons.trash,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
