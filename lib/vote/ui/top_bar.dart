import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(votePageProvider);
    final pageNotifier = ref.watch(votePageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case VotePage.main:
                            controllerNotifier.toggle();
                            break;
                          case VotePage.admin:
                            pageNotifier.setVotePage(VotePage.main);
                            break;
                        }
                      },
                      icon: FaIcon(
                        page == VotePage.main
                            ? FontAwesomeIcons.chevronRight
                            : FontAwesomeIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ));
                },
              ),
            ),
            // const Text(
            //   VoteTextConstants.vote,
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.w500,
            //     color: Color.fromARGB(255, 0, 0, 0),
            //   ),
            // ),
            // const SizedBox(
            //   width: 70,
            // ),
          ],
        ),
      ],
    );
  }
}
