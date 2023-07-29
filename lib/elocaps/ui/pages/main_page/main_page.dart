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
                const SizedBox(height: 15),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Podium(
                                rank: 2,
                                text: "2. ${ranking[1]}",
                                height: 70),
                            Podium(
                                rank: 1,
                                text: "1. ${ranking[0]}",
                                height: 100),
                            Podium(
                              rank: 3,
                              text: "3. ${ranking[2]}",
                              height: 50,
                            ),
                          ],
                        ),
                        ...List.generate(ranking.length - 3, (index) {
                          index += 3;
                          return Podium(
                              rank: index + 1,
                              text: "${index + 1}. ${ranking[index]}",
                              );
                        })])),

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
