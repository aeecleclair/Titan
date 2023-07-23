import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/ui/background_anim.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/main_page/podium.dart';
import 'package:myecl/elocaps/ui/pages/main_page/ranking_dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EloCapsMainPage extends HookConsumerWidget {
  const EloCapsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> ranking = ['Izgû', 'a', 'b', 'c', 'd', 'e'];
    final List<Color> color_rank = [
      const Color.fromARGB(255, 244, 26, 11),
      const Color.fromARGB(255, 248, 164, 39),
      Color.fromARGB(255, 235, 187, 28)
    ];

    final animation = useAnimationController(
        duration: const Duration(milliseconds: 3000), initialValue: 0)
      ..repeat(reverse: true);

    return ElocapsTemplate(
        child: Stack(
      children: [
        Expanded(
            child: CustomPaint(
                size: Size.infinite,
                painter: MyCustomPainter(animation: animation))),
        GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const RankingDialog();
                },
              );
            },
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
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
                    child: const Text("Classement général",
                        style: TextStyle(fontSize: 30, color: Colors.black))),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: ranking.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String nom = entry.value;

                          return Podium(
                            rank: idx + 1,
                            text: "${idx + 1}. $nom",
                            color: idx < 3 ? color_rank[idx] : Colors.grey,
                          );
                        }).toList())),
                const SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [GestureDetector(
                  onTap: () {
                    QR.to(ElocapsRouter.root + ElocapsRouter.history);
                  },
                  child: const MyButton(text: "Voir mes Parties"),
                ),
                GestureDetector(
                  onTap: () {
                    QR.to(ElocapsRouter.root + ElocapsRouter.game);
                  },
                  child: const MyButton(text: "Lancez une partie"),
                ),
              ])],
            ))),
      ],
    ));
  }
}
