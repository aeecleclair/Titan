import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/orders_by_delivery_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class DeliveryUi extends HookConsumerWidget {
  final Delivery delivery;
  const DeliveryUi({super.key, required this.delivery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    final deliveryOrders = ref.watch(adminDeliveryOrderListProvider);
    final deliveryOrdersNotifier =
        ref.watch(adminDeliveryOrderListProvider.notifier);
    final ordersByDeliveryListNotifier =
        ref.watch(orderByDeliveryListProvider.notifier);

    final orders = [];
    deliveryOrders.when(
      data: (data) {
        data[delivery]!.when(
          data: (data) {
            if (data.isNotEmpty) {
              orders.addAll(data);
            } else {
              tokenExpireWrapper(ref, () async {
                final ordersByDelivery = await ordersByDeliveryListNotifier
                    .loadDeliveryOrderList(delivery.id);
                deliveryOrdersNotifier.setTData(delivery, ordersByDelivery);
                ordersByDelivery.when(
                  data: (data) {
                    orders.addAll(data);
                  },
                  loading: () {},
                  error: (error, stack) {},
                );
              });
            }
          },
          loading: () {},
          error: (error, stack) {},
        );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${AMAPTextConstants.the} ${processDate(delivery.deliveryDate)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AMAPColorConstants.textDark)),
                  GestureDetector(
                    onTap: () {
                      deliveryIdNotifier.setId(delivery.id);
                      pageNotifier.setAmapPage(AmapPage.deliveryDetail);
                    },
                    child: const HeroIcon(
                      HeroIcons.arrowTopRightOnSquare,
                      color: AMAPColorConstants.textDark,
                    ),
                  ),
                ],
              ),
              Text(
                  orders.isEmpty
                      ? AMAPTextConstants.noCurrentOrder
                      : '${orders.length} ${AMAPTextConstants.oneOrder}${orders.length != 1 ? "s" : ""}',
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
                  ShrinkButton(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: ((context) => CustomDialogBox(
                              title: AMAPTextConstants.deleteDelivery,
                              descriptions:
                                  '${AMAPTextConstants.deleteDeliveryDescription} ${processDate(delivery.deliveryDate)} ?',
                              onYes: () async {
                                await tokenExpireWrapper(ref, () async {
                                  deliveryListNotifier
                                      .deleteDelivery(delivery)
                                      .then((value) {
                                    if (value) {
                                      displayVoteWithContext(TypeMsg.msg,
                                          AMAPTextConstants.deletedDelivery);
                                    } else {
                                      displayVoteWithContext(TypeMsg.error,
                                          AMAPTextConstants.deletingError);
                                    }
                                  });
                                });
                              })));
                    },
                    waitChild: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            AMAPColorConstants.redGradient1,
                            AMAPColorConstants.redGradient2,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: AMAPColorConstants.redGradient2
                                  .withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            AMAPColorConstants.redGradient1,
                            AMAPColorConstants.redGradient2,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
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
                        size: 22,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ShrinkButton(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: ((context) => CustomDialogBox(
                              title: delivery.status == DeliveryStatus.creation
                                  ? AMAPTextConstants.openDelivery
                                  : delivery.status == DeliveryStatus.orderable
                                      ? AMAPTextConstants.lock
                                      : delivery.status == DeliveryStatus.locked
                                          ? AMAPTextConstants.deliver
                                          : AMAPTextConstants.archive,
                              descriptions: delivery.status ==
                                      DeliveryStatus.creation
                                  ? AMAPTextConstants.openningDelivery
                                  : delivery.status == DeliveryStatus.orderable
                                      ? AMAPTextConstants.lockingDelivery
                                      : delivery.status == DeliveryStatus.locked
                                          ? AMAPTextConstants.deliveringDelivery
                                          : AMAPTextConstants.archivingDelivery,
                              onYes: () async {
                                await tokenExpireWrapper(ref, () async {
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
                                    case DeliveryStatus.delivered:
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
                    waitChild: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors:
                                !(delivery.status == DeliveryStatus.creation)
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
                          boxShadow: [
                            BoxShadow(
                                color: !(delivery.status ==
                                        DeliveryStatus.creation)
                                    ? AMAPColorConstants.redGradient2
                                        .withOpacity(0.5)
                                    : AMAPColorConstants.greenGradient2
                                        .withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const SizedBox(
                          width: 100,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
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
                        boxShadow: [
                          BoxShadow(
                              color:
                                  !(delivery.status == DeliveryStatus.creation)
                                      ? AMAPColorConstants.redGradient2
                                          .withOpacity(0.5)
                                      : AMAPColorConstants.greenGradient2
                                          .withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              delivery.status == DeliveryStatus.creation
                                  ? AMAPTextConstants.openDelivery
                                  : delivery.status == DeliveryStatus.orderable
                                      ? AMAPTextConstants.closeDelivery
                                      : delivery.status == DeliveryStatus.locked
                                          ? AMAPTextConstants.deliverDelivery
                                          : AMAPTextConstants.archiveDelivery,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          HeroIcon(
                            delivery.status == DeliveryStatus.creation
                                ? HeroIcons.lockClosed
                                : delivery.status == DeliveryStatus.orderable
                                    ? HeroIcons.lockOpen
                                    : delivery.status == DeliveryStatus.locked
                                        ? HeroIcons.truck
                                        : HeroIcons.archiveBoxArrowDown,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
