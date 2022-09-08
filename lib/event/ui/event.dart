import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/ui/page_switcher.dart';
import 'package:myecl/event/ui/top_bar.dart';

class EventPage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const EventPage({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(
              controllerNotifier: controllerNotifier,
            ),
            const PageSwitcher()
          ],
        ));
  }
}
