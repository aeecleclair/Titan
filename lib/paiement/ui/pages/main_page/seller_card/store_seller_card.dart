import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/class/user_store.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';

class StoreSellerCard extends ConsumerWidget {
  final UserStore store;
  const StoreSellerCard({super.key, required this.store});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStore = ref.watch(selectedStoreProvider);
    final selectedStoreNotifier = ref.read(selectedStoreProvider.notifier);
    return GestureDetector(
      onTap: () {
        selectedStoreNotifier.updateStore(store);
      },
      child: Container(
        decoration: BoxDecoration(
          color: store.id == selectedStore.id
              ? const Color.fromARGB(255, 6, 75, 75)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: store.id == selectedStore.id
                ? const Color.fromARGB(255, 6, 75, 75)
                : const Color.fromARGB(255, 0, 29, 29),
            width: 1,
          ),
        ),
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: store.id == selectedStore.id
                  ? Color.fromARGB(255, 0, 29, 29)
                  : Color.fromARGB(255, 6, 75, 75),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: AutoSizeText(
                store.name,
                maxLines: 2,
                style: TextStyle(
                  color: store.id == selectedStore.id
                      ? Colors.white
                      : Color.fromARGB(255, 0, 29, 29),
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (store.id != selectedStore.id)
              const HeroIcon(
                HeroIcons.arrowRight,
                color: Color.fromARGB(255, 0, 29, 29),
                size: 25,
              ),
          ],
        ),
      ),
    );
  }
}
