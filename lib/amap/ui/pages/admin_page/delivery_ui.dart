import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class DeliveryUi extends HookConsumerWidget {
  final Delivery delivery;
  const DeliveryUi({super.key, required this.delivery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    final deliverOrders = ref.watch(adminDeliveryOrderListProvider);

    final orders = [];
    deliverOrders.when(
      data: (data) {
        if (data[delivery] != null) {
          data[delivery]!.when(
            data: (data) {
              orders.addAll(data);
            },
            loading: () {},
            error: (error, stack) {},
          );
        }
      },
      loading: () {},
      error: (error, stack) {},
    );
    void displayVoteWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.all(10.0),
        height: 160,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AMAPColorConstants.textDark.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              Text(
                  '${AMAPTextConstants.the} ${processDate(delivery.deliveryDate)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AMAPColorConstants.textDark)),
              Text(
                  orders.isEmpty
                      ? AMAPTextConstants.noCurrentOrder
                      : '${orders.length} ${AMAPTextConstants.order}${orders.length != 1 ? "s" : ""}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AMAPColorConstants.textDark)),
              Text(
                "${delivery.products.length} ${AMAPTextConstants.product}${delivery.products.length != 1 ? "s" : ""}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AMAPColorConstants.textLight),
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => CustomDialogBox(
                              title: delivery.status == DeliveryStatus.creation
                                  ? AMAPTextConstants.openDelivery
                                  // ? AMAPTextConstants.unlock
                                  : AMAPTextConstants.lock,
                              descriptions:
                                  delivery.status == DeliveryStatus.creation
                                      ? AMAPTextConstants.openningDelivery
                                      // ? AMAPTextConstants.unlockingDelivery
                                      : AMAPTextConstants.lockingDelivery,
                              onYes: () {
                                tokenExpireWrapper(ref, () async {
                                  switch (delivery.status) {
                                    case DeliveryStatus.creation:
                                      deliveryListNotifier
                                          .openDelivery(delivery)
                                          .then((value) {
                                        if (value) {
                                          displayVoteWithContext(TypeMsg.msg,
                                              AMAPTextConstants.deliveryOpened);
                                        } else {
                                          displayVoteWithContext(
                                              TypeMsg.error,
                                              AMAPTextConstants
                                                  .deliveryNotOpened);
                                        }
                                      });
                                      break;
                                    case DeliveryStatus.orderable:
                                      deliveryListNotifier
                                          .lockDelivery(delivery)
                                          .then((value) {
                                        if (value) {
                                          displayVoteWithContext(TypeMsg.msg,
                                              AMAPTextConstants.deliveryLocked);
                                        } else {
                                          displayVoteWithContext(
                                              TypeMsg.error,
                                              AMAPTextConstants
                                                  .deliveryNotLocked);
                                        }
                                      });
                                      break;
                                    case DeliveryStatus.locked:
                                      deliveryListNotifier
                                          .deliverDelivery(delivery)
                                          .then((value) {
                                        if (value) {
                                          displayVoteWithContext(
                                              TypeMsg.msg,
                                              AMAPTextConstants
                                                  .deliveryDelivered);
                                        } else {
                                          displayVoteWithContext(
                                              TypeMsg.error,
                                              AMAPTextConstants
                                                  .deliveryNotDelivered);
                                        }
                                      });
                                      break;
                                    case DeliveryStatus.deliverd:
                                      deliveryListNotifier
                                          .archiveDelivery(delivery)
                                          .then((value) {
                                        if (value) {
                                          displayVoteWithContext(
                                              TypeMsg.msg,
                                              AMAPTextConstants
                                                  .deliveryArchived);
                                        } else {
                                          displayVoteWithContext(
                                              TypeMsg.error,
                                              AMAPTextConstants
                                                  .deliveryNotArchived);
                                        }
                                      });
                                      break;
                                  }
                                });
                              })));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      // margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: !(delivery.status == DeliveryStatus.creation)
                              ? [
                                  AMAPColorConstants.redGradient1,
                                  AMAPColorConstants.redGradient2,
                                ]
                              : [
                                  AMAPColorConstants.greenGradient1,
                                  AMAPColorConstants.greenGradient2,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: const Text(
                              AMAPTextConstants.openDelivery,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          HeroIcon(
                            !(delivery.status == DeliveryStatus.creation)
                                ? HeroIcons.lockOpen
                                : HeroIcons.lockClosed,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ],
          ),
        ));
  }
}
