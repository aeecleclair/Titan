import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/cgu_provider.dart';
import 'package:myecl/paiement/providers/register_provider.dart';
import 'package:myecl/paiement/providers/should_display_cgu_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/cgu_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/last_transactions.dart';
import 'package:myecl/paiement/ui/paiement.dart';
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
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const AccountCard();
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const LastTransactions(),
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
