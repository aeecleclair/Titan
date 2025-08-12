import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/advert/ui/components/announcer_item.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';

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

    return AsyncChild(
      value: announcerList,
      builder: (context, userAnnouncers) => HorizontalListView.builder(
        height: 66,
        items: userAnnouncers,
        itemBuilder: (context, e, i) {
          final selected = selectedId.contains(e.id);
          return AnnouncerItem(
            onTap: () {
              if (isNotClickable) {
                return;
              }
              if (multipleSelect) {
                selected
                    ? selectedNotifier.removeAnnouncer(e)
                    : selectedNotifier.addAnnouncer(e);
              } else {
                selectedNotifier.clearAnnouncer();
                if (!selected) {
                  selectedNotifier.addAnnouncer(e);
                }
              }
            },
            name: e.name,
            avatarName: e.name
                .split(' ')
                .take(2)
                .map((s) => s[0].toUpperCase())
                .join(),
            selected: selected,
          );
        },
      ),
    );
  }
}
