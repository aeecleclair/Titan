import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';

class BottomBar extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const BottomBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(pageProvider.notifier);
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    return Column(
      children: [
        Container(
          height: 40,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            pageNotifier.setPage(0);
            hasScrolled.setHasScrolled(false);
          },
          onDoubleTap: () {
            pageNotifier.setPage(0);
            controllerNotifier.toggle();
            hasScrolled.setHasScrolled(false);
          },
          child: Row(
            children: [
              Container(
                width: 25,
              ),
              FaIcon(
                FontAwesomeIcons.gear,
                color: Colors.grey.shade100.withOpacity(0.6),
                size: 25,
              ),
              Container(
                width: 15,
              ),
              Text("Paramètres",
                  style: TextStyle(
                    color: Colors.grey.shade100.withOpacity(0.6),
                    fontSize: 15,
                  ))
            ],
          ),
        ),
        Container(
          height: 20,
        )
      ],
    );
  }
}
