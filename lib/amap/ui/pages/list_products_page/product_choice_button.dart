import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';
import 'package:titan/amap/providers/user_amount_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class ProductChoiceButton extends HookConsumerWidget {
  const ProductChoiceButton({super.key});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: WaitingButton(
              waitingColor: AMAPColorConstants.background,
              builder: (child) => Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AMAPColorConstants.greenGradient1,
                      AMAPColorConstants.greenGradient2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AMAPColorConstants.greenGradient2.withValues(
                        alpha: 0.4,
                      ),
                      offset: const Offset(2, 3),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                alignment: Alignment.center,
                child: child,
              ),
              onTap: () async {
                if (order.amount == 0.0) {
                  displayToast(
                    context,
                    TypeMsg.error,
                    AppLocalizations.of(context)!.amapNoProduct,
                  );
                } else {
                  Order newOrder = order.copyWith(
                    deliveryId: deliveryId,
                    user: me.toSimpleUser(),
                    lastAmount: order.amount,
                  );
                  await tokenExpireWrapper(ref, () async {
                    final updatedOrderMsg = AppLocalizations.of(
                      context,
                    )!.amapUpdatedOrder;
                    final addedOrderMsg = AppLocalizations.of(
                      context,
                    )!.amapAddedOrder;
                    final updatingErrorMsg = AppLocalizations.of(
                      context,
                    )!.amapUpdatingError;
                    final addingErrorMsg = AppLocalizations.of(
                      context,
                    )!.amapAddingError;
                    final value = isEdit
                        ? await orderListNotifier.updateOrder(newOrder)
                        : await orderListNotifier.addOrder(newOrder);
                    if (value) {
                      QR.back();
                      userAmountNotifier.updateCash(
                        order.lastAmount - order.amount,
                      );
                      if (isEdit) {
                        displayToastWithContext(TypeMsg.msg, updatedOrderMsg);
                      } else {
                        displayToastWithContext(TypeMsg.msg, addedOrderMsg);
                      }
                    } else {
                      if (isEdit) {
                        displayToastWithContext(
                          TypeMsg.error,
                          updatingErrorMsg,
                        );
                      } else {
                        displayToastWithContext(TypeMsg.error, addingErrorMsg);
                      }
                    }
                  });
                }
              },
              child: Text(
                "${AppLocalizations.of(context)!.amapConfirm} (${order.amount.toStringAsFixed(2)}€)",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AMAPColorConstants.background,
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 70,
              decoration: BoxDecoration(
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
                    color: AMAPColorConstants.redGradient2.withValues(
                      alpha: 0.4,
                    ),
                    offset: const Offset(2, 3),
                    blurRadius: 5,
                  ),
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
                    descriptions: AppLocalizations.of(
                      context,
                    )!.amapDeletingOrder,
                    title: AppLocalizations.of(context)!.amapDeleting,
                    onYes: () {
                      orderNotifier.setOrder(Order.empty());
                      QR.back();
                    },
                  ),
                );
              } else {
                QR.back();
              }
            },
          ),
        ],
      ),
    );
  }
}
