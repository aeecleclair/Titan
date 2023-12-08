import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/class/game_player.dart';
import 'package:myecl/elocaps/providers/game_provider.dart';
import 'package:myecl/elocaps/providers/mode_chosen_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/game_page/player_form.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGameCreated = useState(false);
    final modeChosen = ref.watch(modeChosenProvider);
    final modeChosenNotifier = ref.read(modeChosenProvider.notifier);
    final gameNotifier = ref.watch(gameProvider.notifier);
    final isFocused = useState(List.generate(4, (index) => false));
    final user = ref.watch(userProvider);
    final keys = [
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
    ];
    final playersForm = [
      PlayerForm(
          index: 0,
          isFocused: isFocused,
          formKey: keys[0],
          queryController:
              useTextEditingController(text: user.toSimpleUser().getName()),
          user: useState(user.toSimpleUser())),
      PlayerForm(
          index: 1,
          isFocused: isFocused,
          formKey: keys[1],
          queryController: useTextEditingController(text: ""),
          user: useState(SimpleUser.empty())),
      PlayerForm(
          index: 2,
          isFocused: isFocused,
          formKey: keys[2],
          queryController: useTextEditingController(text: ""),
          user: useState(SimpleUser.empty())),
      PlayerForm(
          index: 3,
          isFocused: isFocused,
          formKey: keys[3],
          queryController: useTextEditingController(text: ""),
          user: useState(SimpleUser.empty())),
    ];
    final scores = [
      useTextEditingController(text: ""),
      useTextEditingController(text: ""),
    ];
    final players = useState(<SimpleUser>[]);

    return ElocapsTemplate(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const AlignLeftText("Mode de jeu",
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
                      item.name,
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black),
                    ));
              },
              height: 40),
          const SizedBox(height: 30),
          Column(
            children: modeChosen == CapsMode.cd
                ? [
                    const AlignLeftText("Equipe 1",
                        padding: EdgeInsets.symmetric(horizontal: 30)),
                    const SizedBox(height: 10),
                    playersForm[0],
                    playersForm[1],
                    const SizedBox(height: 20),
                    const AlignLeftText("Equipe 2",
                        padding: EdgeInsets.symmetric(horizontal: 30)),
                    const SizedBox(height: 10),
                    playersForm[2],
                    playersForm[3],
                  ]
                : [
                    const AlignLeftText("Joueur 1",
                        padding: EdgeInsets.symmetric(horizontal: 30)),
                    const SizedBox(height: 20),
                    playersForm[0],
                    const SizedBox(height: 20),
                    const AlignLeftText("Joueur 2",
                        padding: EdgeInsets.symmetric(horizontal: 30)),
                    const SizedBox(height: 20),
                    playersForm[1],
                  ],
          ),
          const SizedBox(height: 30),
          if (!isGameCreated.value)
            GestureDetector(
              onTap: () {
                if (modeChosen == CapsMode.cd) {
                  if (playersForm[0].formKey.currentState!.validate() &&
                      playersForm[1].formKey.currentState!.validate() &&
                      playersForm[2].formKey.currentState!.validate() &&
                      playersForm[3].formKey.currentState!.validate()) {
                    isGameCreated.value = true;
                  }
                } else if (playersForm[0].formKey.currentState!.validate() &&
                    playersForm[1].formKey.currentState!.validate()) {
                  isGameCreated.value = true;
                }
                players.value = playersForm
                    .map<SimpleUser>((e) => e.user.value)
                    .where((user) => user.id != "")
                    .toList();
              },
              child: const MyButton(text: "Lancer la partie"),
            ),
          const SizedBox(height: 20),
          if (isGameCreated.value) ...[
            const AlignLeftText("Scores finaux",
                padding: EdgeInsets.symmetric(horizontal: 30)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                  key: key,
                  child: Row(
                      children: modeChosen == CapsMode.cd
                          ? [
                              Expanded(
                                child: TextEntry(
                                  label: "Score équipe 1",
                                  controller: scores[0],
                                  isInt: true,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextEntry(
                                  label: "Score équipe 2",
                                  controller: scores[1],
                                  isInt: true,
                                ),
                              ),
                            ]
                          : [
                              Expanded(
                                child: TextEntry(
                                  label: "Score joueur 1",
                                  controller: scores[0],
                                  isInt: true,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextEntry(
                                  label: "Score joueur 2",
                                  controller: scores[1],
                                  isInt: true,
                                ),
                              ),
                            ])),
            ),
            const SizedBox(height: 30),
            GestureDetector(
                onTap: () {
                  gameNotifier.createGame(Game(
                      timestamp: DateTime.now(),
                      gamePlayers: players.value.asMap().entries.map((entry) {
                        int index = entry.key;
                        SimpleUser e = entry.value;
                        final isTeamOne = index < players.value.length / 2;
                        return GamePlayer(
                          user: e,
                          eloGain: 0,
                          playerId: e.id,
                          quarters: isTeamOne
                              ? int.parse(scores[0].text)
                              : int.parse(scores[1].text),
                          team: isTeamOne ? 1 : 2,
                        );
                      }).toList(),
                      id: '',
                      isConfirmed: false,
                      mode: modeChosen));
                  QR.to(ElocapsRouter
                      .root); // Peut être mettre une verif que la partie est bien créee avant de retourner à la page d'accueil
                },
                child: const MyButton(text: "Enregistrer la partie"))
          ],
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
