import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/providers/store_provider.dart';
import 'package:myecl/paiement/providers/stores_list_provider.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminStoreCard extends ConsumerWidget {
  final Store store;
  const AdminStoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeListNotifier = ref.watch(storeListProvider.notifier);
    final storeNotifier = ref.watch(storeProvider.notifier);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 29, 29).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                store.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const CardButton(
                  colors: [
                    Color.fromARGB(255, 6, 75, 75),
                    Color.fromARGB(255, 0, 29, 29),
                  ],
                  child: HeroIcon(
                    HeroIcons.userGroup,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  storeNotifier.updateStore(store);
                  QR.to(
                    PaymentRouter.root +
                        PaymentRouter.admin +
                        PaymentRouter.addEditStore,
                  );
                },
                child: const CardButton(
                  colors: [
                    Color.fromARGB(255, 6, 75, 75),
                    Color.fromARGB(255, 0, 29, 29),
                  ],
                  child: HeroIcon(
                    HeroIcons.pencilSquare,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              WaitingButton(
                onTap: () async {
                  await storeListNotifier.deleteStore(store);
                },
                builder: (child) => CardButton(
                  colors: const [
                    Color(0xFF9E131F),
                    Color(0xFF590512),
                  ],
                  child: child,
                ),
                child: const HeroIcon(
                  HeroIcons.trash,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
