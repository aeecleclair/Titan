import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/store.dart';
import 'package:titan/paiement/providers/store_provider.dart';
import 'package:titan/paiement/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddStoreCard extends ConsumerWidget {
  const AddStoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeNotifier = ref.watch(storeProvider.notifier);
    return GestureDetector(
      onTap: () {
        storeNotifier.updateStore(Store.empty());
        QR.to(
          PaymentRouter.root + PaymentRouter.admin + PaymentRouter.addEditStore,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(
                255,
                0,
                29,
                29,
              ).withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: HeroIcon(
            HeroIcons.plus,
            size: 40,
            color: Color.fromARGB(255, 0, 29, 29),
          ),
        ),
      ),
    );
  }
}
