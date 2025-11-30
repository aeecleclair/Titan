import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';

class StoreSellerCard extends ConsumerWidget {
  final UserStore store;
  const StoreSellerCard({super.key, required this.store});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStore = ref.watch(selectedStoreProvider);
    final selectedStoreNotifier = ref.read(selectedStoreProvider.notifier);

    final isSelected = store.id == selectedStore.id;

    return GestureDetector(
      onTap: () {
        selectedStoreNotifier.updateStore(store);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: isSelected
                  ? Color.fromARGB(255, 0, 29, 29)
                  : Color.fromARGB(255, 6, 75, 75),
              child: (isSelected)
                  ? const HeroIcon(
                      HeroIcons.check,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 25,
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: AutoSizeText(
                store.name,
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
