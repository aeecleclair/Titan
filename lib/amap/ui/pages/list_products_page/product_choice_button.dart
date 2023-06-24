import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class Boutons extends HookConsumerWidget {
  const Boutons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final deliveryId = ref.watch(deliveryIdProvider);
    final orderListNotifier = ref.watch(userOrderListProvider.notifier);
    final userAmountNotifier = ref.watch(userAmountProvider.notifier);
    final me = ref.watch(userProvider);
    final isEdit = order.id != Order.empty().id;
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: ShrinkButton(
                waitChild: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      AMAPColorConstants.greenGradient1,
                      AMAPColorConstants.greenGradient2
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                          color: AMAPColorConstants.greenGradient2
                              .withOpacity(0.4),
                          offset: const Offset(2, 3),
                          blurRadius: 5)
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AMAPColorConstants.background,
                  ),
                ),
                onTap: () async {
                  if (order.amount == 0.0) {
                    displayToast(
                        context, TypeMsg.error, AMAPTextConstants.noProduct);
                  } else {
                    Order newOrder = order.copyWith(
                        deliveryId: deliveryId,
                        user: me.toSimpleUser(),
                        lastAmount: order.amount);
                    await tokenExpireWrapper(ref, () async {
                      final value = isEdit
                          ? await orderListNotifier.updateOrder(newOrder)
                          : await orderListNotifier.addOrder(newOrder);
                      if (value) {
                        QR.back();
                        userAmountNotifier
                            .updateCash(order.lastAmount - order.amount);
                        if (isEdit) {
                          displayToastWithContext(
                              TypeMsg.msg, AMAPTextConstants.updatedOrder);
                        } else {
                          displayToastWithContext(
                              TypeMsg.msg, AMAPTextConstants.addedOrder);
                        }
                      } else {
                        if (isEdit) {
                          displayToastWithContext(
                              TypeMsg.error, AMAPTextConstants.updatingError);
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, AMAPTextConstants.addingError);
                        }
                      }
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      AMAPColorConstants.greenGradient1,
                      AMAPColorConstants.greenGradient2
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                          color: AMAPColorConstants.greenGradient2
                              .withOpacity(0.4),
                          offset: const Offset(2, 3),
                          blurRadius: 5)
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${AMAPTextConstants.confirm} (${order.amount.toStringAsFixed(2)}€)",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AMAPColorConstants.background),
                  ),
                )),
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  AMAPColorConstants.redGradient1,
                  AMAPColorConstants.redGradient2
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: AMAPColorConstants.redGradient2.withOpacity(0.4),
                      offset: const Offset(2, 3),
                      blurRadius: 5)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              alignment: Alignment.center,
              child: HeroIcon(
                HeroIcons.xMark,
                size: 35,
                color: AMAPColorConstants.background,
              ),
            ),
            onTap: () {
              if (order.amount != 0.0 || order.id != Order.empty().id) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialogBox(
                        descriptions: AMAPTextConstants.deletingOrder,
                        title: AMAPTextConstants.deleting,
                        onYes: () {
                          orderNotifier.setOrder(Order.empty());
                          QR.back();
                        }));
              } else {
                QR.back();
              }
            },
          ),
        ]));
  }
}
