import 'dart:math';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/providers/orderable_deliveries.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/main_page/collection_slot_selector.dart';
import 'package:myecl/amap/ui/pages/main_page/delivery_section.dart';
import 'package:myecl/amap/ui/pages/main_page/orders_section.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final isAdmin = ref.watch(isAmapAdmin);
    final delivery = ref.watch(deliveryProvider);
    final deliveriesNotifier = ref.watch(deliveryListProvider.notifier);
    final ordersNotifier = ref.watch(userOrderListProvider.notifier);
    final soldeNotifier = ref.watch(userAmountProvider.notifier);
    final solde = ref.watch(userAmountProvider);
    final showPanel = useState(false);
    final me = ref.watch(userProvider);
    final deliveryProductListNotifier =
        ref.watch(deliveryProductListProvider.notifier);
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 500), initialValue: 0);
    final popAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));
    final shakingAnimation = useAnimationController(
        duration: const Duration(milliseconds: 700), initialValue: 0);

    final orderableDeliveries = ref.watch(orderableDeliveriesProvider);
    final orderableDeliveriesIds = orderableDeliveries
        .map((delivery) => delivery.id)
        .toList(growable: false);

    void displayToastWithoutContext(TypeMsg type, String text) {
      displayToast(context, type, text);
    }

    return Refresher(
        onRefresh: () async {
          await ordersNotifier.loadOrderList(me.id);
          await soldeNotifier.loadCashByUser(me.id);
          await deliveriesNotifier.loadDeliveriesList();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: AnimatedBuilder(
                          builder: (context, child) {
                            return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.translation(Vector3(
                                        sin(shakingAnimation.value *
                                                pi *
                                                10.0) *
                                            10,
                                        0.0,
                                        0.0)) *
                                    Matrix4.rotationZ(
                                      sin(shakingAnimation.value * pi * 3.0) /
                                          4,
                                    ),
                                child: Text(
                                    solde.when(
                                        data: (s) =>
                                            "${AMAPTextConstants.amount} : ${s.balance.toStringAsFixed(2)}€",
                                        error: (e, s) => "Erreur",
                                        loading: () =>
                                            AMAPTextConstants.loading),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: shakingAnimation.value !=
                                                shakingAnimation.value.round()
                                            ? AMAPColorConstants.redGradient1
                                            : AMAPColorConstants
                                                .greenGradient1)));
                          },
                          animation: shakingAnimation,
                        )),
                    if (isAdmin)
                      GestureDetector(
                        onTap: () {
                          pageNotifier.setAmapPage(AmapPage.admin);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              gradient: const RadialGradient(
                                colors: [
                                  AMAPColorConstants.greenGradient1,
                                  AMAPColorConstants.greenGradient2
                                ],
                                center: Alignment.topLeft,
                                radius: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AMAPColorConstants.textDark
                                        .withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5))
                              ]),
                          child: Row(
                            children: const [
                              HeroIcon(HeroIcons.userGroup,
                                  color: Colors.white),
                              SizedBox(width: 10),
                              Text("Admin",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    OrderSection(
                      onEdit: () {
                        showPanel.value = true;
                        animation.forward();
                      },
                      onTap: () {
                        pageNotifier.setAmapPage(AmapPage.detailPage);
                      },
                      addOrder: () {
                        if (orderableDeliveriesIds.contains(delivery.id)) {
                          solde.whenData(
                            (s) {
                              if (s.balance > 0) {
                                orderNotifier.setOrder(Order.empty());
                                animation.forward();
                                showPanel.value = true;
                              } else {
                                shakingAnimation.forward(from: 0);
                              }
                            },
                          );
                        } else {
                          displayToastWithoutContext(TypeMsg.error,
                              AMAPTextConstants.noOpennedDelivery);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DeliverySection(
                      showSelected: false,
                    ),
                  ],
                ),
                AnimatedBuilder(
                  builder: (context, child) {
                    return Transform.translate(
                        offset: Offset(
                            0,
                            (1 - popAnimation.value) *
                                (MediaQuery.of(context).size.height)),
                        child: child);
                  },
                  animation: animation,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 150,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [
                          AMAPColorConstants.textLight,
                          AMAPColorConstants.greenGradient1,
                        ],
                        center: Alignment.topRight,
                        radius: 1.5,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AMAPColorConstants.textDark.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Ajouter une commande',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              IconButton(
                                icon: const HeroIcon(
                                  HeroIcons.xMark,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  animation.reverse();
                                  showPanel.value = false;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Row(
                                  children: CollectionSlot.values
                                      .map((e) => CollectionSlotSelector(
                                          collectionSlot: e))
                                      .toList())),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const DeliverySection(),
                        const SizedBox(
                          height: 20,
                        ),
                        ShrinkButton(
                            onTap: () async {
                              if (orderableDeliveriesIds
                                  .contains(delivery.id)) {
                                orderNotifier.setOrder(order.copyWith(
                                  deliveryId: delivery.id,
                                ));
                                await tokenExpireWrapper(ref, () async {
                                  await deliveryProductListNotifier
                                      .loadProductList(delivery.products);
                                });
                                pageNotifier.setAmapPage(AmapPage.addProducts);
                              } else {
                                displayToastWithoutContext(TypeMsg.error,
                                    AMAPTextConstants.notPlannedDelivery);
                              }
                            },
                            waitChild: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                  colors: [
                                    AMAPColorConstants.greenGradient2,
                                    AMAPColorConstants.textDark,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AMAPColorConstants.textDark
                                        .withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(2, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                width: double.infinity,
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                              ),
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                  colors: [
                                    AMAPColorConstants.greenGradient2,
                                    AMAPColorConstants.textDark,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AMAPColorConstants.textDark
                                        .withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(2, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                width: double.infinity,
                                child: const Center(
                                  child: Text("Étape suivante",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white)),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
