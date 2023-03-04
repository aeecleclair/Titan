import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';

class AnnouncerBar extends HookConsumerWidget {
  final bool useUserAnnouncers;
  const AnnouncerBar({super.key, required this.useUserAnnouncers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.read(announcerProvider.notifier);
    final announcerList = useUserAnnouncers? ref.watch(userAnnouncerListProvider):ref.watch(announcerListProvider);
    return announcerList.when(
      data: (userAnnouncers) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15),
            ...userAnnouncers.map(
              (e) => GestureDetector(
                onTap: () {selected.contains(e)?selectedNotifier.removeAnnounce(e):selectedNotifier.addAnnounce(e);},
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Chip(
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e.name,
                          style: TextStyle(
                              color: selected.contains(e)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      backgroundColor: selected.contains(e)
                          ? Colors.black
                          : Colors.grey.shade200,
                    )),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
      error: (Object error, StackTrace stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
