import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/player_list_provider.dart';
import 'package:myecl/elocaps/ui/pages/main_page/leader_board_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class LeaderBoard extends HookConsumerWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardPlayers = ref.watch(playerListProvider);
    return AsyncChild(
        value: leaderBoardPlayers,
        builder: (context, players) => Container(
            padding: const EdgeInsets.only(top: 20),
            height: max(MediaQuery.of(context).size.height - 240,
                (players.length - 3) * 80.0),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 246, 246),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )),
            child: Column(
              children: players
                  .skip(3)
                  .map((e) =>
                      LeaderBoardCard(player: e, index: players.indexOf(e) + 1))
                  .toList(),
            )));
  }
}
