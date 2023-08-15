import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/providers/mode_chosen_provider.dart';
import 'package:myecl/elocaps/ui/pages/game_page/player_form.dart';

class ModeDialog extends HookConsumerWidget {
  const ModeDialog({
    Key? key,
    required this.listForm,
  }) : super(key: key);

  final ValueNotifier<List<PlayerForm>> listForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CapsMode> capsModeList = CapsMode.values;
    final players = [
      PlayerForm(num: 1, queryController: useTextEditingController(text: "")),
      PlayerForm(num: 2, queryController: useTextEditingController(text: "")),
      PlayerForm(num: 3, queryController: useTextEditingController(text: "")),
      PlayerForm(num: 4, queryController: useTextEditingController(text: "")),
    ];
    final modeChosen = ref.watch(modeChosenProvider);
    final modeChosenNotifier = ref.watch(modeChosenProvider.notifier);

    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 251, 209, 206),
          ],
          radius: 2,
          center: Alignment.topLeft,
        )),
        height: 80 + capsModeList.length * 35.0,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Quel mode ?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 16, 14, 14)),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: capsModeList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      modeChosenNotifier.setMode(capsModeList[index]);
                      listForm.value = capsModeList[index] == CapsMode.cd
                          ? players
                          : players.sublist(0, 2);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          capsModeList[index].name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 17, 16, 16)),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
