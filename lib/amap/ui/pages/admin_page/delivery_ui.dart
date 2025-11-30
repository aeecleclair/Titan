import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/providers/delivery_order_list_provider.dart';
import 'package:titan/amap/providers/delivery_product_list_provider.dart';
import 'package:titan/amap/providers/orders_by_delivery_provider.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/amap/providers/selected_list_provider.dart';
import 'package:titan/amap/router.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DeliveryUi extends HookConsumerWidget {
  final Delivery delivery;
  const DeliveryUi({super.key, required this.delivery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    final deliveryOrders = ref.watch(
      adminDeliveryOrderListProvider.select((value) => value[delivery.id]),
    );
    final deliveryProductListNotifier = ref.watch(
      deliveryProductListProvider.notifier,
    );
    final deliveryOrdersNotifier = ref.watch(
      adminDeliveryOrderListProvider.notifier,
    );
    final ordersByDeliveryListNotifier = ref.watch(
      orderByDeliveryListProvider.notifier,
    );

    void displayVoteWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final style = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AMAPColorConstants.textDark,
    );

    final tp = TextPainter(
      text: TextSpan(text: delivery.name, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 3,
    );
    final maxTextWidth = 200.0;
    tp.layout(maxWidth: maxTextWidth);
    final lines = tp.computeLineMetrics().length;

    return CardLayout(
      id: delivery.id,
      height: 155 + 26.0 * (lines),
      width: 280,
      shadowColor: AMAPColorConstants.textDark.withValues(alpha: 0.2),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxTextWidth),
                            child: Text(
                              delivery.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AMAPColorConstants.textDark,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          Text(
                            ' ${AMAPTextConstants.the} ${processDate(delivery.deliveryDate)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AMAPColorConstants.textDark,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          deliveryIdNotifier.setId(delivery.id);
                          deliveryProductListNotifier.loadProductList(
                            delivery.products,
                          );
                          QR.to(
                            AmapRouter.root +
                                AmapRouter.admin +
                                AmapRouter.detailDelivery,
                          );
                        },
                        child: const HeroIcon(
                          HeroIcons.arrowTopRightOnSquare,
                          color: AMAPColorConstants.textDark,
                        ),
                      ),
                    ],
                  ),
                  AutoLoaderChild(
                    group: deliveryOrders,
                    notifier: deliveryOrdersNotifier,
                    mapKey: delivery.id,
                    listLoader: (deliveryId) => ordersByDeliveryListNotifier
                        .loadDeliveryOrderList(deliveryId),
                    dataBuilder: (context, orders) {
                      return Text(
                        orders.isEmpty
                            ? AMAPTextConstants.noCurrentOrder
                            : '${orders.length} ${AMAPTextConstants.oneOrder}${orders.length != 1 ? "s" : ""}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AMAPColorConstants.textDark,
                        ),
                      );
                    },
                  ),
                  Text(
                    "${delivery.products.length} ${AMAPTextConstants.product}${delivery.products.length != 1 ? "s" : ""}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AMAPColorConstants.textLight,
                    ),
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
                      QR.to(
                        AmapRouter.root +
                            AmapRouter.admin +
                            AmapRouter.addEditDelivery,
                      );
                      final deliveryProductsIds = delivery.products
                          .map((e) => e.id)
                          .toList(growable: false);
                      final products = ref.watch(productListProvider);
                      final selectedNotifier = ref.watch(
                        selectedListProvider.notifier,
                      );
                      products.maybeWhen(
                        data: (data) {
                          for (int i = 0; i < data.length; i++) {
                            if (!deliveryProductsIds.contains(data[i].id)) {
                              selectedNotifier.toggle(i);
                            }
                          }
                        },
                        orElse: () {},
                      );
                    },
                    child: const CardButton(
                      colors: [
                        AMAPColorConstants.greenGradient1,
                        AMAPColorConstants.greenGradient1,
                      ],
                      child: HeroIcon(
                        HeroIcons.pencil,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                if (delivery.status == DeliveryStatus.creation)
                  WaitingButton(
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
                                      displayVoteWithContext(
                                        TypeMsg.msg,
                                        AMAPTextConstants.deletedDelivery,
                                      );
                                    } else {
                                      displayVoteWithContext(
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
                      colors: const [
                        AMAPColorConstants.redGradient1,
                        AMAPColorConstants.redGradient2,
                      ],
                      child: child,
                    ),
                    child: const HeroIcon(
                      HeroIcons.trash,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                WaitingButton(
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
                        descriptions: delivery.status == DeliveryStatus.creation
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
                                  displayVoteWithContext(
                                    TypeMsg.msg,
                                    AMAPTextConstants.deliveryOpened,
                                  );
                                } else {
                                  displayVoteWithContext(
                                    TypeMsg.error,
                                    AMAPTextConstants.deliveryNotOpened,
                                  );
                                }
                                break;
                              case DeliveryStatus.available:
                                final value = await deliveryListNotifier
                                    .lockDelivery(delivery);
                                if (value) {
                                  displayVoteWithContext(
                                    TypeMsg.msg,
                                    AMAPTextConstants.deliveryLocked,
                                  );
                                } else {
                                  displayVoteWithContext(
                                    TypeMsg.error,
                                    AMAPTextConstants.deliveryNotLocked,
                                  );
                                }
                                break;
                              case DeliveryStatus.locked:
                                final value = await deliveryListNotifier
                                    .deliverDelivery(delivery);
                                if (value) {
                                  displayVoteWithContext(
                                    TypeMsg.msg,
                                    AMAPTextConstants.deliveryDelivered,
                                  );
                                } else {
                                  displayVoteWithContext(
                                    TypeMsg.error,
                                    AMAPTextConstants.deliveryNotDelivered,
                                  );
                                }
                                break;
                              case DeliveryStatus.delivered:
                                final value = await deliveryListNotifier
                                    .archiveDelivery(delivery);
                                if (value) {
                                  displayVoteWithContext(
                                    TypeMsg.msg,
                                    AMAPTextConstants.deliveryArchived,
                                  );
                                } else {
                                  displayVoteWithContext(
                                    TypeMsg.error,
                                    AMAPTextConstants.deliveryNotArchived,
                                  );
                                }
                                break;
                            }
                          });
                        },
                      )),
                    );
                  },
                  builder: (child) => Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
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
                          color: !(delivery.status == DeliveryStatus.creation)
                              ? AMAPColorConstants.redGradient2.withValues(
                                  alpha: 0.5,
                                )
                              : AMAPColorConstants.greenGradient2.withValues(
                                  alpha: 0.5,
                                ),
                          blurRadius: 10,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: child,
                  ),
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
                            color: Colors.white,
                            fontSize: 20,
                          ),
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
