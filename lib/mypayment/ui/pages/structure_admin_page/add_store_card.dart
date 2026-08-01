import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/store.dart';
import 'package:titan/mypayment/providers/store_provider.dart';
import 'package:titan/mypayment/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class AddStoreCard extends ConsumerWidget {
  const AddStoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeNotifier = ref.watch(storeProvider.notifier);
    final isDarkTheme = ref.watch(themeProvider);
    return GestureDetector(
      onTap: () {
        storeNotifier.updateStore(Store.empty());
        QR.to(
          PaymentRouter.root +
              PaymentRouter.structureStores +
              PaymentRouter.addEditStore,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: HeroIcon(
            HeroIcons.plus,
            size: 40,
            color: MyPaymentColors(isDarkTheme).backgroundGradient2,
          ),
        ),
      ),
    );
  }
}
