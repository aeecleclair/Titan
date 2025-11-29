import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ticketing/providers/announcer_provider.dart';
import 'package:titan/ticketing/providers/announcer_list_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';

class AnnouncerBar extends HookConsumerWidget {
  final bool useUserAnnouncers;
  final bool multipleSelect;
  final bool isNotClickable;
  const AnnouncerBar({
    super.key,
    required this.multipleSelect,
    required this.useUserAnnouncers,
    this.isNotClickable = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(announcerProvider);
    final selectedId = selected.map((e) => e.id).toList();
    final selectedNotifier = ref.read(announcerProvider.notifier);
    final announcerList = useUserAnnouncers
        ? ref.watch(userAnnouncerListProvider)
        : ref.watch(announcerListProvider);
    final darkerColor = (isNotClickable) ? Colors.grey[800] : Colors.black;

    return AsyncChild(
      value: announcerList,
      builder: (context, userAnnouncers) => HorizontalListView.builder(
        height: 40,
        items: userAnnouncers,
        itemBuilder: (context, e, i) => GestureDetector(
          onTap: () {
            if (isNotClickable) {
              return;
            }
            if (multipleSelect) {
              selectedId.contains(e.id)
                  ? selectedNotifier.removeAnnouncer(e)
                  : selectedNotifier.addAnnouncer(e);
            } else {
              bool contain = selectedId.contains(e.id);
              selectedNotifier.clearAnnouncer();
              if (!contain) {
                selectedNotifier.addAnnouncer(e);
              }
            }
          },
          child: ItemChip(
            selected: selectedId.contains(e.id),
            child: Text(
              e.name,
              style: TextStyle(
                color: selectedId.contains(e.id) ? Colors.white : darkerColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
