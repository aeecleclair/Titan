import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

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
        builder: (context, userAnnouncers) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(width: 15),
                ...userAnnouncers.map(
                  (e) => GestureDetector(
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
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Chip(
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.name,
                              style: TextStyle(
                                  color: selectedId.contains(e.id)
                                      ? Colors.white
                                      : darkerColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: selectedId.contains(e.id)
                              ? darkerColor
                              : Colors.grey.shade200,
                        )),
                  ),
                ),
                const SizedBox(width: 15),
              ]),
            ));
  }
}
