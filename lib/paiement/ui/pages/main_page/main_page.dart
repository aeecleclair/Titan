import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/tos_provider.dart';
import 'package:myecl/paiement/providers/is_payment_admin.dart';
import 'package:myecl/paiement/providers/my_history_provider.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';
import 'package:myecl/paiement/providers/register_provider.dart';
import 'package:myecl/paiement/providers/should_display_tos_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/account_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/tos_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/last_transactions.dart';
import 'package:myecl/paiement/ui/pages/main_page/flip_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_list.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class PaymentMainPage extends HookConsumerWidget {
  const PaymentMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldDisplayTosDialog = ref.watch(shouldDisplayTosDialogProvider);
    final shouldDisplayTosDialogNotifier =
        ref.read(shouldDisplayTosDialogProvider.notifier);
    final tos = ref.watch(tosProvider);
    final tosNotifier = ref.read(tosProvider.notifier);
    final registerNotifier = ref.read(registerProvider.notifier);
    final mySellers = ref.watch(myStoresProvider);
    final mySellersNotifier = ref.read(myStoresProvider.notifier);
    final myHistoryNotifier = ref.read(myHistoryProvider.notifier);
    final isAdmin = ref.watch(isPaymentAdminProvider);
    final flipped = useState(true);

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0,
    );

    toggle() {
      flipped.value = !flipped.value;
      if (flipped.value) {
        controller.reverse();
      } else {
        controller.forward();
      }
    }

    tos.maybeWhen(
      orElse: () {},
      error: (e, s) async {
        final value = await registerNotifier.register();
        value.maybeWhen(
          orElse: () {},
          data: (value) async {
            if (value) {
              tosNotifier.getTOS();
            }
          },
        );
      },
    );

    return PaymentTemplate(
      child: shouldDisplayTosDialog
          ? Refresher(
              onRefresh: () async {
                await mySellersNotifier.getMyStores();
                await myHistoryNotifier.getHistory();
              },
              child: TOSDialogBox(
                descriptions: tos.maybeWhen(
                  orElse: () => '',
                  data: (tos) => tos.tosContent,
                ),
                title: "Nouvelle TOS",
                onYes: () {
                  tos.maybeWhen(
                    orElse: () {},
                    data: (tos) async {
                      final value = await tosNotifier.signTOS(
                        tos.copyWith(
                          acceptedTosVersion: tos.latestTosVersion,
                        ),
                      );
                      if (value) {
                        await mySellersNotifier.getMyStores();
                        await myHistoryNotifier.getHistory();
                        shouldDisplayTosDialogNotifier.update(false);
                      }
                    },
                  );
                },
                onNo: () {
                  shouldDisplayTosDialogNotifier.update(false);
                },
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                AsyncChild(
                  value: mySellers,
                  builder: (context, mySellers) {
                    if (mySellers.isEmpty && !isAdmin) {
                      return SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: const AccountCard(
                          toggle: null,
                        ),
                      );
                    }
                    return SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: FlipCard(
                        back: StoreCard(
                          toggle: toggle,
                        ),
                        front: AccountCard(
                          toggle: toggle,
                        ),
                        controller: controller,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Visibility(
                          visible: controller.value.abs() < 1,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: 1 - controller.value.abs(),
                            child: const LastTransactions(),
                          ),
                        ),
                        Visibility(
                          visible: controller.value.abs() > 0,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: controller.value.abs(),
                            child: const StoreList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }
}
