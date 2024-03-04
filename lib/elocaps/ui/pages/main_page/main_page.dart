import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/providers/leader_board_player_map_notifier.dart';
import 'package:myecl/elocaps/providers/mode_chosen_provider.dart';
import 'package:myecl/elocaps/providers/player_list_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/main_page/leader_board.dart';
import 'package:myecl/elocaps/ui/pages/main_page/podium.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class EloCapsMainPage extends HookConsumerWidget {
  const EloCapsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardPlayerNotifier = ref.watch(playerListProvider.notifier);
    final leaderBoardPlayerList = ref.watch(leaderBoardPlayerListProvider);
    final leaderBoardPlayerListNotifier =
        ref.read(leaderBoardPlayerListProvider.notifier);
    final modeChosen = ref.watch(modeChosenProvider);
    final modeChosenNotifier = ref.watch(modeChosenProvider.notifier);

    return ElocapsTemplate(
        child: Refresher(
            onRefresh: () async {
              leaderBoardPlayerNotifier.loadRanking;
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const AlignLeftText(ElocapsTextConstant.gameMode,
                        padding: EdgeInsets.symmetric(horizontal: 30)),
                    const SizedBox(height: 20),
                    HorizontalListView.builder(
                        items: CapsMode.values,
                        itemBuilder: (context, item, i) {
                          final selected = item == modeChosen;
                          return ItemChip(
                              selected: selected,
                              onTap: () {
                                modeChosenNotifier.setMode(item);
                              },
                              child: Text(
                                capsModeToString(item),
                                style: TextStyle(
                                    color:
                                        selected ? Colors.white : Colors.black),
                              ));
                        },
                        height: 40),
                    const SizedBox(height: 20),
                    AutoLoaderChild(
                      value: leaderBoardPlayerList,
                      mapKey: modeChosen,
                      notifier: leaderBoardPlayerListNotifier,
                      listLoader: leaderBoardPlayerNotifier.loadRanking,
                      dataBuilder: (context, players) => SingleChildScrollView(
                        child: Column(children: [
                          Podium(players: players),
                          LeaderBoard(players: players),
                        ]),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      modeChosenNotifier.setMode(CapsMode.values.first);
                      QR.to(ElocapsRouter.root + ElocapsRouter.game);
                    },
                    child: const MyButton(
                      text: ElocapsTextConstant.play,
                    ),
                  ),
                ),
              ],
            )));
  }
}
