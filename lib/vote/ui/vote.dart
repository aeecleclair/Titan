import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/ui/page_switcher.dart';
import 'package:myecl/vote/ui/top_bar.dart';

class VoteHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const VoteHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(votePageProvider);
    final pageNotifier = ref.watch(votePageProvider.notifier);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          switch (page) {
            case VotePage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }
            case VotePage.admin:
              pageNotifier.setVotePage(VotePage.main);
              break;
          }
          return false;
        },
        child: Column(
          children: [
            TopBar(
              controllerNotifier: controllerNotifier,
            ),
            const Expanded(child: PageSwitcher()),
          ],
        ),
      ),
    );
  }
}
