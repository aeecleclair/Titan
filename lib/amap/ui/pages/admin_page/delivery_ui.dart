import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/orders_by_delivery_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/card_button.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DeliveryUi extends HookConsumerWidget {
  final Delivery delivery;
  const DeliveryUi({super.key, required this.delivery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    final deliveryOrders = ref.watch(adminDeliveryOrderListProvider);
    final deliveryProductListNotifier =
        ref.watch(deliveryProductListProvider.notifier);
    final deliveryOrdersNotifier =
        ref.watch(adminDeliveryOrderListProvider.notifier);
    final ordersByDeliveryListNotifier =
        ref.watch(orderByDeliveryListProvider.notifier);

    final orders = [];
    deliveryOrders.when(
      data: (data) {
        if (data.containsKey(delivery.id)) {
          data[delivery.id]!.item1.when(
                data: (d) {
                  if (d.isNotEmpty) {
                    orders.addAll(d);
                  } else if (!data[delivery.id]!.item2) {
                    Future.delayed(const Duration(milliseconds: 1), () {
                      deliveryOrdersNotifier.setTData(
                          delivery.id, const AsyncLoading());
                    });
                    tokenExpireWrapper(ref, () async {
                      final ordersByDelivery =
                          await ordersByDeliveryListNotifier
                              .loadDeliveryOrderList(delivery.id);
                      await deliveryOrdersNotifier.setTData(
                          delivery.id, ordersByDelivery);
                      ordersByDelivery.when(
                        data: (data) {
                          orders.addAll(data);
                        },
                        loading: () {},
                        error: (error, stack) {},
                      );
                      deliveryOrdersNotifier.toggleExpanded(delivery.id);
                    });
                  }
                },
                loading: () {},
                error: (error, stack) {},
              );
        } else {
          Future.delayed(const Duration(milliseconds: 1), () {
            deliveryOrdersNotifier.setTData(delivery.id, const AsyncLoading());
          });
          tokenExpireWrapper(ref, () async {
            final ordersByDelivery = await ordersByDeliveryListNotifier
                .loadDeliveryOrderList(delivery.id);
            await deliveryOrdersNotifier.setTData(
                delivery.id, ordersByDelivery);
            ordersByDelivery.when(
              data: (data) {
                orders.addAll(data);
              },
              loading: () {},
              error: (error, stack) {},
            );
            deliveryOrdersNotifier.toggleExpanded(delivery.id);
          });
        }
      },
      loading: () {},
      error: (error, stack) {},
    );
    void displayVoteWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      height: 160,
      width: 280,
      shadowColor: AMAPColorConstants.textDark.withOpacity(0.2),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                          deliveryProductListNotifier
                              .loadProductList(delivery.products);
                          QR.to(AmapRouter.root +
                              AmapRouter.admin +
                              AmapRouter.detailDelivery);
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
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: (delivery.status == DeliveryStatus.creation)
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (delivery.status == DeliveryStatus.creation)
                  GestureDetector(
                    onTap: () async {
                      deliveryIdNotifier.setId(delivery.id);
                      QR.to(AmapRouter.root +
                          AmapRouter.admin +
                          AmapRouter.addEditDelivery);
                      final deliveryProductsIds = delivery.products
                          .map((e) => e.id)
                          .toList(growable: false);
                      final products = ref.watch(productListProvider);
                      final selectedNotifier =
                          ref.watch(selectedListProvider.notifier);
                      products.when(
                        data: (data) {
                          for (int i = 0; i < data.length; i++) {
                            if (!deliveryProductsIds.contains(data[i].id)) {
                              selectedNotifier.toggle(i);
                            }
                          }
                        },
                        loading: () {},
                        error: (error, stack) {},
                      );
                    },
                    child: const CardButton(
                      color: AMAPColorConstants.greenGradient1,
                      gradient: AMAPColorConstants.greenGradient1,
                      child: HeroIcon(
                        HeroIcons.pencil,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                if (delivery.status == DeliveryStatus.creation)
                  ShrinkButton(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: ((context) => CustomDialogBox(
                              title: AMAPTextConstants.deleteDelivery,
                              descriptions:
                                  AMAPTextConstants.deleteDeliveryDescription,
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
                    builder: (child) => CardButton(
                        color: AMAPColorConstants.redGradient1,
                        gradient: AMAPColorConstants.redGradient2,
                        child: child),
                    child: const HeroIcon(
                      HeroIcons.trash,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ShrinkButton(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: ((context) => CustomDialogBox(
                            title: delivery.status == DeliveryStatus.creation
                                ? AMAPTextConstants.openDelivery
                                : delivery.status == DeliveryStatus.available
                                    ? AMAPTextConstants.lock
                                    : delivery.status == DeliveryStatus.locked
                                        ? AMAPTextConstants.deliver
                                        : AMAPTextConstants.archive,
                            descriptions: delivery.status ==
                                    DeliveryStatus.creation
                                ? AMAPTextConstants.openningDelivery
                                : delivery.status == DeliveryStatus.available
                                    ? AMAPTextConstants.lockingDelivery
                                    : delivery.status == DeliveryStatus.locked
                                        ? AMAPTextConstants.deliveringDelivery
                                        : AMAPTextConstants.archivingDelivery,
                            onYes: () async {
                              await tokenExpireWrapper(ref, () async {
                                switch (delivery.status) {
                                  case DeliveryStatus.creation:
                                    final value = await deliveryListNotifier
                                        .openDelivery(delivery);
                                    if (value) {
                                      displayVoteWithContext(TypeMsg.msg,
                                          AMAPTextConstants.deliveryOpened);
                                    } else {
                                      displayVoteWithContext(TypeMsg.error,
                                          AMAPTextConstants.deliveryNotOpened);
                                    }
                                    break;
                                  case DeliveryStatus.available:
                                    final value = await deliveryListNotifier
                                        .lockDelivery(delivery);
                                    if (value) {
                                      displayVoteWithContext(TypeMsg.msg,
                                          AMAPTextConstants.deliveryLocked);
                                    } else {
                                      displayVoteWithContext(TypeMsg.error,
                                          AMAPTextConstants.deliveryNotLocked);
                                    }
                                    break;
                                  case DeliveryStatus.locked:
                                    final value = await deliveryListNotifier
                                        .deliverDelivery(delivery);
                                    if (value) {
                                      displayVoteWithContext(TypeMsg.msg,
                                          AMAPTextConstants.deliveryDelivered);
                                    } else {
                                      displayVoteWithContext(
                                          TypeMsg.error,
                                          AMAPTextConstants
                                              .deliveryNotDelivered);
                                    }
                                    break;
                                  case DeliveryStatus.delivered:
                                    final value = await deliveryListNotifier
                                        .archiveDelivery(delivery);
                                    if (value) {
                                      displayVoteWithContext(TypeMsg.msg,
                                          AMAPTextConstants.deliveryArchived);
                                    } else {
                                      displayVoteWithContext(
                                          TypeMsg.error,
                                          AMAPTextConstants
                                              .deliveryNotArchived);
                                    }
                                    break;
                                }
                              });
                            })));
                  },
                  builder: (child) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                      child: child),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          delivery.status == DeliveryStatus.creation
                              ? AMAPTextConstants.openDelivery
                              : delivery.status == DeliveryStatus.available
                                  ? AMAPTextConstants.closeDelivery
                                  : delivery.status == DeliveryStatus.locked
                                      ? AMAPTextConstants.endingDelivery
                                      : AMAPTextConstants.archiveDelivery,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 10),
                      HeroIcon(
                        delivery.status == DeliveryStatus.creation
                            ? HeroIcons.lockOpen
                            : delivery.status == DeliveryStatus.available
                                ? HeroIcons.lockClosed
                                : delivery.status == DeliveryStatus.locked
                                    ? HeroIcons.truck
                                    : HeroIcons.archiveBoxArrowDown,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
