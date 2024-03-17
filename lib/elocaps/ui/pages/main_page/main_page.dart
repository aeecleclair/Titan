import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/providers/leader_board_player_map_notifier.dart';
import 'package:myecl/elocaps/providers/mode_chosen_provider.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
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
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class EloCapsMainPage extends HookConsumerWidget {
  const EloCapsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardPlayerNotifier = ref.watch(playerListProvider.notifier);
    final modeChosen = ref.watch(modeChosenProvider);
    final me = ref.watch(userProvider);
    final leaderBoardPlayerList = ref.watch(
        leaderBoardPlayerListProvider.select((value) => value[modeChosen]));
    final leaderBoardPlayerListNotifier =
        ref.read(leaderBoardPlayerListProvider.notifier);
    final modeChosenNotifier = ref.watch(modeChosenProvider.notifier);
    final history = ref.watch(playerHistoProvider);

    final displayBadge = history.maybeWhen(
        data: ((games) => games
            .where((e) => !e.isConfirmed && !e.isCancelled)
            .any((element) => !element.gamePlayers
                .where((user) => user.playerId == me.id)
                .first
                .hasConfirmed)),
        orElse: () => false);
    return ElocapsTemplate(
        child: Stack(
      children: [
        Refresher(
            onRefresh: () async {
              leaderBoardPlayerNotifier.loadRanking;
            },
            child: Column(
              children: [
                const SizedBox(height: 5),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: HorizontalListView.builder(
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
                                      color: selected
                                          ? Colors.white
                                          : Colors.black),
                                ));
                          },
                          height: 40),
                    ),
                    GestureDetector(
                      onTap: () {
                        QR.to(ElocapsRouter.root + ElocapsRouter.history);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: (displayBadge)
                              ? Badge(
                                  isLabelVisible: displayBadge,
                                  smallSize: 10,
                                  child: const HeroIcon(
                                    HeroIcons.clipboardDocumentList,
                                    size: 30,
                                  ),
                                )
                              : const HeroIcon(
                                  HeroIcons.clipboardDocumentList,
                                  size: 30,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AutoLoaderChild(
                  group: leaderBoardPlayerList,
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
            )),
        Positioned(
          bottom: 10,
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
    ));
  }
}
