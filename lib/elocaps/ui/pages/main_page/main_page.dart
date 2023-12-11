import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/player_list_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/main_page/leader_board.dart';
import 'package:myecl/elocaps/ui/pages/main_page/podium.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EloCapsMainPage extends HookConsumerWidget {
  const EloCapsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardPlayers = ref.watch(playerListProvider);

    return ElocapsTemplate(
        child: Stack(
      children: [
        AsyncChild(
          value: leaderBoardPlayers,
          builder: (context, players) => const SingleChildScrollView(
            child: Column(children: [
              Podium(),
              LeaderBoard(),
            ]),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              QR.to(ElocapsRouter.root + ElocapsRouter.game);
            },
            child: const MyButton(
              text: "Jouer",
            ),
          ),
        ),
      ],
    ));
  }
}
