import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/player_list_provider.dart';
import 'package:myecl/elocaps/ui/pages/main_page/podium_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/user/providers/user_provider.dart';

class Podium extends HookConsumerWidget {
const Podium({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final leaderBoardPlayers = ref.watch(playerListProvider);
    final me = ref.watch(userProvider);
    return AsyncChild(
      value: leaderBoardPlayers,
      builder: (context, players) => Container(
                height: 200,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (players.length > 1)
            PodiumCard(
                player: players[1],
                index: 1,
                isMe: players[1].user.id == me.id,
              ),
          if (players.isNotEmpty)
            PodiumCard(
                player: players[0],
                index: 0,
                isMe: players[0].user.id == me.id,
              ),
          if (players.length > 2)
             PodiumCard(
                player: players[2],
                index: 2,
                isMe: players[2].user.id == me.id,
              ),
        ],
      ),
    ));
  }
}