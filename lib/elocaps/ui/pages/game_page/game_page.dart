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
    final playersForm = [
      PlayerForm(
          index: 0,
          isFocused: isFocused,
          queryController: useTextEditingController(text: user.toSimpleUser().getName()),
          user: useState(user.toSimpleUser())),
      PlayerForm(
          index: 1,
          isFocused: isFocused,
          queryController: useTextEditingController(text: ""),
          user: useState(SimpleUser.empty())),
      PlayerForm(
          index: 2,
          isFocused: isFocused,
          queryController: useTextEditingController(text: ""),
          user: useState(SimpleUser.empty())),
      PlayerForm(
          index: 3,
          isFocused: isFocused,
          queryController: useTextEditingController(text: ""),
          user: useState(SimpleUser.empty())),
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
          // if (!isGameCreated.value) ...[
          //   const SizedBox(height: 20),
          //   GestureDetector(
          //       onTap: () {
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return ModeDialog(
          //               players: playersForm,
          //             );
          //           },
          //         );
          //       },
          //       child: AnimatedBuilder(
          //           animation: animation,
          //           builder: (context, child) {
          //             return Container(
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(5),
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.black.withOpacity(0.5),
          //                         blurRadius: 7,
          //                       )
          //                     ],
          //                     gradient: RadialGradient(
          //                       colors: const [
          //                         Color.fromARGB(255, 201, 34, 21),
          //                         Color.fromARGB(255, 248, 187, 55),
          //                         Color.fromARGB(255, 201, 34, 21),
          //                         Color.fromARGB(255, 176, 16, 4),
          //                       ],
          //                       stops: [
          //                         0.1 + 0.6 * animation.value,
          //                         0.25 + 0.6 * animation.value,
          //                         0.35 + 0.65 * animation.value,
          //                         1,
          //                       ],
          //                       radius: 2,
          //                       center: Alignment(
          //                           0.65 +
          //                               math.cos(3 * animation.value +
          //                                   math.pi / 2),
          //                           0.2 - math.sin(animation.value)),
          //                     )),
          //                 padding: const EdgeInsets.all(10),
          //                 child: Text(
          //                     "Mode actuel: ${modeChosen.toString().split('.').last}",
          //                     style: const TextStyle(
          //                         fontSize: 25,
          //                         fontWeight: FontWeight.w700,
          //                         color:
          //                             Color.fromARGB(255, 248, 248, 248))));
          //           })),
          const SizedBox(height: 20),
          Form(
            key: key,
            child: Column(
              children: modeChosen == CapsMode.cd
                  ? playersForm
                  : playersForm.sublist(0, 2),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
              onTap: () {
                players.value = playersForm
                    .map<SimpleUser>((e) => e.user.value)
                    .where((user) => user.id != "")
                    .toList();

                if (modeChosen == CapsMode.cd && players.value.length == 4) {
                  isGameCreated.value = true;
                } else if (modeChosen != CapsMode.cd &&
                    players.value.length == 2) {
                  isGameCreated.value = true;
                }
              },
              child: const MyButton(text: "Lancer la partie")),
          // ],
          if (isGameCreated.value) ...[
            const SizedBox(height: 20),
            ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 12, 0, 0),
                        Color.fromARGB(255, 63, 2, 2),
                        Color.fromARGB(255, 251, 118, 70),
                      ],
                      tileMode: TileMode.mirror,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ).createShader(bounds),
                child: const Text(
                  "Scores finaux",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                )),
            const SizedBox(height: 20),
            Form(
                key: key,
                child: Column(
                    children: playersForm
                        .map((e) => e.queryController.text != ""
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${e.queryController.text} : ",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 7, 8, 14))),
                                  Container(
                                      child: Text(
                                          "ici on met le score //bug textformField à voir"))
                                ],
                              )
                            : Container())
                        .where((element) => element != Container())
                        .toList())),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  gameNotifier.createGame(Game(
                      timestamp: DateTime.now(),
                      gamePlayers: players.value.asMap().entries.map((entry) {
                        int index = entry.key;
                        SimpleUser e = entry.value;
                        return GamePlayer(
                          user: e,
                          eloGain: 0,
                          playerId: e.id,
                          quarters: index == 1 ? 4 : 2,
                          team: index < players.value.length / 2 ? 1 : 2,
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
