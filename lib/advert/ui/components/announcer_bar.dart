import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/tools/constants.dart';
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
          return GestureDetector(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(color: ColorConstants.tertiary, width: 3)
                          : null,
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(
                        e.name
                            .split(' ')
                            .take(2)
                            .map((s) => s[0].toUpperCase())
                            .join(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? ColorConstants.onTertiary
                              : ColorConstants.tertiary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 55,
                    child: AutoSizeText(
                      e.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: selected
                            ? ColorConstants.onTertiary
                            : ColorConstants.tertiary,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
