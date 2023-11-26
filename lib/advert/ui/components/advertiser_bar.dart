import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class AdvertiserBar extends HookConsumerWidget {
  final bool useUserAdvertisers;
  final bool multipleSelect;
  final bool isNotClickable;
  const AdvertiserBar({
    super.key,
    required this.multipleSelect,
    required this.useUserAdvertisers,
    this.isNotClickable = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(advertiserProvider);
    final selectedId = selected.map((e) => e.id).toList();
    final selectedNotifier = ref.read(advertiserProvider.notifier);
    final advertiserList = useUserAdvertisers
        ? ref.watch(userAdvertiserListProvider)
        : ref.watch(advertiserListProvider);
    final darkerColor = (isNotClickable) ? Colors.grey[800] : Colors.black;

    return AsyncChild(
      value: advertiserList,
      builder: (context, userAdvertisers) => HorizontalListView.builder(
        height: 40,
        items: userAdvertisers,
        itemBuilder: (context, e, i) => GestureDetector(
          onTap: () {
            if (isNotClickable) {
              return;
            }
            if (multipleSelect) {
              selectedId.contains(e.id)
                  ? selectedNotifier.removeAdvertiser(e)
                  : selectedNotifier.addAdvertiser(e);
            } else {
              bool contain = selectedId.contains(e.id);
              selectedNotifier.clearAdvertiser();
              if (!contain) {
                selectedNotifier.addAdvertiser(e);
              }
            }
          },
          child: ItemChip(
            selected: selectedId.contains(e.id),
            child: Text(
              e.name,
              style: TextStyle(
                  color: selectedId.contains(e.id) ? Colors.white : darkerColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
