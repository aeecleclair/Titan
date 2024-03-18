import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/class/game_player.dart';
import 'package:myecl/elocaps/providers/game_provider.dart';
import 'package:myecl/elocaps/providers/mode_chosen_provider.dart';
import 'package:myecl/elocaps/providers/players_provider.dart';
import 'package:myecl/elocaps/providers/scores_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/game_page/player_form.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGameCreated = useState(false);
    final modeChosen = ref.watch(modeChosenProvider);
    final modeChosenNotifier = ref.read(modeChosenProvider.notifier);
    final gameNotifier = ref.watch(gameProvider.notifier);
    final me = ref.watch(userProvider);
    final players = ref.watch(playersProvider);
    final playersNotifier = ref.watch(playersProvider.notifier);
    final playersKey = GlobalKey<FormState>();
    final scoreKey = GlobalKey<FormState>();
    final playersForm = [
      PlayerForm(
        index: 0,
        enable: false,
        queryController:
            useTextEditingController(text: me.toSimpleUser().getName()),
      ),
      PlayerForm(
        index: 1,
        enable: true,
        queryController: useTextEditingController(text: ""),
      ),
      PlayerForm(
        index: 2,
        enable: true,
        queryController: useTextEditingController(text: ""),
      ),
      PlayerForm(
        index: 3,
        enable: true,
        queryController: useTextEditingController(text: ""),
      ),
    ];
    final scores = ref.watch(scoresProvider);
    final scoresNotifier = ref.read(scoresProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return ElocapsTemplate(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ));
              },
              height: 40),
          const SizedBox(height: 30),
          Form(
            key: playersKey,
            child: Column(
              children: modeChosen == CapsMode.cd
                  ? [
                      const AlignLeftText(ElocapsTextConstant.team_1,
                          padding: EdgeInsets.symmetric(horizontal: 30)),
                      const SizedBox(height: 10),
                      playersForm[0],
                      playersForm[1],
                      const SizedBox(height: 20),
                      const AlignLeftText(ElocapsTextConstant.team_2,
                          padding: EdgeInsets.symmetric(horizontal: 30)),
                      const SizedBox(height: 10),
                      playersForm[2],
                      playersForm[3],
                    ]
                  : [
                      const AlignLeftText(ElocapsTextConstant.player_1,
                          padding: EdgeInsets.symmetric(horizontal: 30)),
                      const SizedBox(height: 20),
                      playersForm[0],
                      const SizedBox(height: 20),
                      const AlignLeftText(ElocapsTextConstant.player_2,
                          padding: EdgeInsets.symmetric(horizontal: 30)),
                      const SizedBox(height: 20),
                      playersForm[1],
                    ],
            ),
          ),
          const SizedBox(height: 30),
          if (!isGameCreated.value)
            GestureDetector(
              onTap: () {
                if (playersKey.currentState!.validate()) {
                  isGameCreated.value = true;
                }
              },
              child: const MyButton(text: ElocapsTextConstant.gameStart),
            ),
          const SizedBox(height: 20),
          if (isGameCreated.value) ...[
            const AlignLeftText(ElocapsTextConstant.result,
                padding: EdgeInsets.symmetric(horizontal: 30)),
            const SizedBox(height: 20),
            Builder(builder: (context) {
              isGameCreated.value = false;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: scoreKey,
                  child: Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          scoresNotifier.oneWin();
                          isGameCreated.value = true;
                        },
                        child: MyButton(
                          margin: const EdgeInsets.all(0),
                          enabled: scores[0] == 1,
                          text: modeChosen == CapsMode.cd
                              ? '${players[0]?.nickname ?? players[0]?.firstname} et ${players[1]?.nickname ?? players[1]?.firstname} ${ElocapsTextConstant.wonCd}'
                              : '${players[0]?.nickname ?? players[0]?.firstname} ${ElocapsTextConstant.won}',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: GestureDetector(
                        onTap: () {
                          scoresNotifier.equality();
                          isGameCreated.value = true;
                        },
                        child: MyButton(
                          enabled: scores[0] == 0,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          text: ElocapsTextConstant.draw,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          scoresNotifier.twoWin();
                          isGameCreated.value = true;
                        },
                        child: MyButton(
                          margin: const EdgeInsets.all(0),
                          enabled: scores[1] == 1,
                          text: modeChosen == CapsMode.cd
                              ? '${players[2]?.nickname ?? players[2]?.firstname} et ${players[3]?.nickname ?? players[3]?.firstname} ${ElocapsTextConstant.wonCd}'
                              : '${players[1]?.nickname ?? players[1]?.firstname} ${ElocapsTextConstant.won}',
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            }),
            const SizedBox(height: 30),
            GestureDetector(
                onTap: () async {
                  if (!scoreKey.currentState!.validate() ||
                      !playersKey.currentState!.validate()) {
                    return;
                  }
                  final game = Game(
                      timestamp: DateTime.now(),
                      gamePlayers: players.entries.map((entry) {
                        int index = entry.key;
                        SimpleUser e = entry.value;
                        final isTeamOne = index < players.length / 2;
                        return GamePlayer(
                          user: e,
                          eloGain: 0,
                          playerId: e.id,
                          score: isTeamOne ? scores[0] : scores[1],
                          team: isTeamOne ? 1 : 2,
                          hasConfirmed: false,
                        );
                      }).toList(),
                      id: '',
                      isConfirmed: false,
                      isCancelled: false,
                      mode: modeChosen);
                  final value = await gameNotifier.createGame(game);
                  if (value) {
                    playersNotifier.reset();
                    displayToastWithContext(
                        TypeMsg.msg, ElocapsTextConstant.savedGame);
                    QR.to(ElocapsRouter.root);
                  } else {
                    displayToastWithContext(
                        TypeMsg.error, ElocapsTextConstant.errorSavingGame);
                  }
                },
                child: const MyButton(text: ElocapsTextConstant.saveTheGame))
          ],
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
