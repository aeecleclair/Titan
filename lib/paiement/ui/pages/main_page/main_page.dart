import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/cgu_provider.dart';
import 'package:myecl/paiement/providers/is_payment_admin.dart';
import 'package:myecl/paiement/providers/register_provider.dart';
import 'package:myecl/paiement/providers/should_display_cgu_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/account_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/cgu_dialog.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/last_transactions.dart';
import 'package:myecl/paiement/ui/pages/main_page/store_card/store_card.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/user/providers/user_provider.dart';

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
    final isAdmin = ref.watch(isPaymentAdmin);
    final firstPageController = PageController(viewportFraction: 0.8);

    final scrollValue = useState(0.0);

    firstPageController.addListener(() {
      scrollValue.value = firstPageController.page ?? 0.0;
    });

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

    final userCards = [
      [
        AccountCard(),
        LastTransactions(),
      ],
      if (isAdmin)
        [
          StoreCard(),
          Container(color: Colors.red),
        ],
    ];

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
                    controller: firstPageController,
                    itemCount: userCards.length,
                    itemBuilder: (context, index) {
                      return userCards[index][0];
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Stack(
                  children: userCards.map((e) {
                    return Visibility(
                      visible:
                          (scrollValue.value - userCards.indexOf(e)).abs() < 1,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: clampDouble(
                          1 - (scrollValue.value - userCards.indexOf(e)).abs(),
                          0,
                          1,
                        ),
                        child: e[1],
                      ),
                    );
                  }).toList(),
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
