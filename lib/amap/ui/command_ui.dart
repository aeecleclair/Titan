import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class CommandeUI extends HookConsumerWidget {
  final Order order;
  final void Function() onTap, onEdit;
  final bool showButton, isDetail;
  const CommandeUI(
      {super.key,
      required this.order,
      required this.onTap,
      required this.onEdit,
      this.showButton = true,
      this.isDetail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListNotifier = ref.watch(userOrderListProvider.notifier);
    final orderNotifier = ref.watch(orderProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.all(12.0),
        width: 195,
        height: isDetail ? 120 : 160,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${AMAPTextConstants.the} ${processDate(order.deliveryDate)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AMAPColorConstants.textDark)),
                  if (!isDetail)
                    GestureDetector(
                      onTap: () {
                        orderNotifier.setOrder(order);
                        onTap();
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
              const SizedBox(height: 3),
              Text(
                collectionSlotToString(order.collectionSlot),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AMAPColorConstants.textDark),
              ),
              const Spacer(),
              if (!isDetail)
                showButton
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              orderNotifier.setOrder(order);
                              onEdit();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AMAPColorConstants.greenGradient1,
                                    AMAPColorConstants.greenGradient2,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: AMAPColorConstants.greenGradient2
                                          .withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3))
                                ],
                              ),
                              child: const HeroIcon(
                                HeroIcons.pencil,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const Spacer(),
                          ShrinkButton(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: ((context) => CustomDialogBox(
                                      title: AMAPTextConstants.delete,
                                      descriptions:
                                          AMAPTextConstants.deletingOrder,
                                      onYes: () async {
                                        await tokenExpireWrapper(ref, () async {
                                          orderListNotifier
                                              .deleteOrder(order)
                                              .then((value) {
                                            if (value) {
                                              displayToastWithContext(
                                                  TypeMsg.msg,
                                                  AMAPTextConstants
                                                      .unlockedDelivery);
                                            } else {
                                              displayToastWithContext(
                                                  TypeMsg.error,
                                                  AMAPTextConstants
                                                      .updatingError);
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
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
                                      color: AMAPColorConstants.redGradient2
                                          .withOpacity(0.5),
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
                    : const Text(
                        AMAPTextConstants.locked,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AMAPColorConstants.textDark),
                      )
            ],
          ),
        ));
  }
}
