import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/pages/main_page/podium.dart';

class RankingDialog extends HookConsumerWidget {
  const RankingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> ranking = [
      'Izgû',
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];
    final double width = MediaQuery.of(context).size.width - 10;

    final animation = useAnimationController(
        duration: const Duration(milliseconds: 7000), initialValue: 0)
      ..repeat();

    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                  width: width,
                  height: MediaQuery.of(context).size.height - 50,
                  margin: const EdgeInsets.only(left: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(105, 35, 21, 0),
                          blurRadius: 10,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: RadialGradient(
                          colors: const [
                            Color.fromARGB(235, 255, 255, 255),
                            Color.fromARGB(205, 235, 235, 235),
                          ],
                          transform: GradientRotation(
                              360 * animation.value * pi / 180),
                          center: Alignment.bottomRight,
                          radius: 1.5)),
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Podium(
                              rank: 2,
                                text: "2. ${ranking[1]}",

                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 60),
                            Podium(
                                rank: 1,
                                text: "1. ${ranking[0]}",
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 80),
                            Podium(
                              rank: 3,
                              text: "3. ${ranking[2]}",
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: 40,
                            ),
                          ],
                        ),
                        ...List.generate(ranking.length - 3, (index) {
                          index += 3;
                          return Podium(
                              rank: index + 1,
                              text: "${index + 1}. ${ranking[index]}",
                              width: width - 20);
                        })
                      ]))));
        });
  }
}
