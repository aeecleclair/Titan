import 'package:titan/amap/providers/delivery_provider.dart';
import 'package:titan/amap/providers/available_deliveries.dart';
import 'package:titan/amap/router.dart';
import 'package:titan/amap/ui/amap.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/providers/delivery_product_list_provider.dart';
import 'package:titan/amap/providers/is_amap_admin_provider.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/amap/providers/user_amount_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/main_page/collection_slot_selector.dart';
import 'package:titan/amap/ui/pages/main_page/delivery_section.dart';
import 'package:titan/amap/ui/pages/main_page/orders_section.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AmapMainPage extends HookConsumerWidget {
  const AmapMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final isAdmin = ref.watch(isAmapAdminProvider);
    final delivery = ref.watch(deliveryProvider);
    final deliveriesNotifier = ref.read(deliveryListProvider.notifier);
    final ordersNotifier = ref.read(userOrderListProvider.notifier);
    final balanceNotifier = ref.read(userAmountProvider.notifier);
    final balance = ref.watch(userAmountProvider);
    final showPanel = useState(false);
    final me = ref.watch(userProvider);
    final deliveryProductListNotifier = ref.watch(
      deliveryProductListProvider.notifier,
    );
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0,
    );
    final popAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    final availableDeliveries = ref.watch(availableDeliveriesProvider);
    final availableDeliveriesIds = availableDeliveries
        .map((delivery) => delivery.id)
        .toList(growable: false);

    void displayToastWithoutContext(TypeMsg type, String text) {
      displayToast(context, type, text);
    }

    return AmapTemplate(
      child: Refresher(
        onRefresh: () async {
          await ordersNotifier.loadOrderList(me.id);
          await balanceNotifier.loadCashByUser(me.id);
          await deliveriesNotifier.loadDeliveriesList();
        },
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: AsyncChild(
                      value: balance,
                      builder: (context, s) => Text(
                        "${AMAPTextConstants.amount} : ${s.balance.toStringAsFixed(2)}€",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AMAPColorConstants.greenGradient1,
                        ),
                      ),
                      loaderColor: AMAPColorConstants.greenGradient1,
                    ),
                  ),
                  if (isAdmin)
                    AdminButton(
                      onTap: () {
                        QR.to(AmapRouter.root + AmapRouter.admin);
                      },
                      colors: const [
                        AMAPColorConstants.greenGradient1,
                        AMAPColorConstants.greenGradient2,
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                        QR.to(AmapRouter.root + AmapRouter.detailOrder);
                      },
                      addOrder: () {
                        balance.whenData((s) {
                          orderNotifier.setOrder(Order.empty());
                          animation.forward();
                          showPanel.value = true;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const DeliverySection(showSelected: false),
                  ],
                ),
                AnimatedBuilder(
                  builder: (context, child) {
                    return Opacity(
                      opacity: popAnimation.value,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          (1 - popAnimation.value) *
                              (MediaQuery.of(context).size.height),
                        ),
                        child: child,
                      ),
                    );
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
                        topRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AMAPColorConstants.textDark.withValues(
                            alpha: 0.3,
                          ),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AlignLeftText(
                                AMAPTextConstants.addOrder,
                                color: Colors.white,
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
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Row(
                              children: CollectionSlot.values
                                  .map(
                                    (e) => CollectionSlotSelector(
                                      collectionSlot: e,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        DeliverySection(editable: order.id == Order.empty().id),
                        const SizedBox(height: 20),
                        WaitingButton(
                          onTap: () async {
                            if (availableDeliveriesIds.contains(delivery.id)) {
                              await tokenExpireWrapper(ref, () async {
                                await deliveryProductListNotifier
                                    .loadProductList(delivery.products);
                              });
                              QR.to(AmapRouter.root + AmapRouter.listProduct);
                            } else {
                              displayToastWithoutContext(
                                TypeMsg.error,
                                AMAPTextConstants.noSelectedDelivery,
                              );
                            }
                          },
                          builder: (child) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
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
                                  color: AMAPColorConstants.textDark.withValues(
                                    alpha: 0.3,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: child,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                AMAPTextConstants.nextStep,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
