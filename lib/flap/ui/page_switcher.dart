import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/providers/flap_page_provider.dart';
import 'package:myecl/flap/ui/game_page/game_page.dart';
import 'package:myecl/flap/ui/leaderboard_page/leaderboard_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(flapPageProvider);
    switch (page) {
      case FlapPage.main:
        return const GamePage();
      case FlapPage.leaderBoard:
        return const LeaderBoardPage();
    }
  }
}
