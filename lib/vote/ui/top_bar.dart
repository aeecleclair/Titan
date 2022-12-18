import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';

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
          height: 15,
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
                          case VotePage.addSection:
                            pageNotifier.setVotePage(VotePage.admin);
                            break;
                          case VotePage.addEditPretendance:
                            pageNotifier.setVotePage(VotePage.admin);
                            break;
                          case VotePage.detailPageFromMain:
                            pageNotifier.setVotePage(VotePage.main);
                            break;
                          case VotePage.detailPageFromAdmin:
                            pageNotifier.setVotePage(VotePage.admin);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == VotePage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(VoteTextConstants.vote,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
