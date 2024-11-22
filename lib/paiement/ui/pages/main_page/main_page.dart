import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/cgu_provider.dart';
import 'package:myecl/paiement/providers/is_payment_admin.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';
import 'package:myecl/paiement/providers/register_provider.dart';
import 'package:myecl/paiement/providers/should_display_cgu_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/account_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/cgu_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/last_transactions.dart';
import 'package:myecl/paiement/ui/pages/main_page/flip_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/seller_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/seller_list.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class PaymentMainPage extends HookConsumerWidget {
  const PaymentMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldDisplayCguDialog = ref.watch(shouldDisplayCguDialogProvider);
    final shouldDisplayCguDialogNotifier =
        ref.read(shouldDisplayCguDialogProvider.notifier);
    final cgu = ref.watch(cguProvider);
    final cguNotifier = ref.read(cguProvider.notifier);
    final registerNotifier = ref.read(registerProvider.notifier);
    final mySellers = ref.watch(myStoresProvider);
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

    cgu.maybeWhen(
      orElse: () {},
      error: (e, s) async {
        final value = await registerNotifier.register();
        value.maybeWhen(
          orElse: () {},
          data: (value) async {
            if (value) {
              cguNotifier.getCGU();
            }
          },
        );
      },
    );

    return PaymentTemplate(
      child: Refresher(
        onRefresh: () async {},
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                AsyncChild(
                  value: mySellers,
                  builder: (context, mySellers) {
                    if (mySellers.isEmpty) {
                      return const AccountCard(
                        toggle: null,
                      );
                    }
                    return SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: FlipCard(
                        back: SellerCard(
                          toggle: toggle,
                          seller: mySellers.first,
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
                            child: LastTransactions(),
                          ),
                        ),
                        Visibility(
                          visible: controller.value.abs() > 0,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: controller.value.abs(),
                            child: SellerList(),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
            if (shouldDisplayCguDialog)
              CGUDialogBox(
                descriptions: cgu.maybeWhen(
                  orElse: () => '',
                  data: (cgu) => cgu.cguContent,
                ),
                title: "Nouvelle CGU",
                onYes: () {
                  cgu.maybeWhen(
                    orElse: () {},
                    data: (cgu) async {
                      final value = await cguNotifier.signCGU(
                        cgu.copyWith(
                          acceptedCguVersion: cgu.latestCguVersion,
                        ),
                      );
                      if (value) {
                        shouldDisplayCguDialogNotifier.update(false);
                      }
                    },
                  );
                },
                onNo: () {
                  shouldDisplayCguDialogNotifier.update(false);
                },
              ),
          ],
        ),
      ),
    );
  }
}
