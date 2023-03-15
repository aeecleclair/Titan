import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/tools/constants.dart';

class PrizeDialog extends HookConsumerWidget {
  const PrizeDialog({
    Key? key,
    required this.prize,
  }) : super(key: key);
  final Lot prize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(children: <Widget>[
          Container(
            width: 350,
            height: 300,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: TombolaColorConstants.writtenWhite.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 8,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                gradient: RadialGradient(colors: [
                  Colors.white,
                  TombolaColorConstants.gradient1.withOpacity(0.8),
                ], center: Alignment(1, 1), radius: 0.6),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
          ),
          Container(
              width: 350,
              height: 300,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          TombolaColorConstants.writtenWhite.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 8,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                  gradient: RadialGradient(colors: [
                    TombolaColorConstants.gradient2,
                    TombolaColorConstants.gradient1.withOpacity(0.8),
                  ], center: Alignment(-0.9, -0.9), radius: 1.4),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: TombolaColorConstants.writtenWhite,
                            width: 3),
                      ),
                    ),
                    child: Center(
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => RadialGradient(
                                      colors: [
                                        TombolaColorConstants.writtenWhite,
                                        Color.fromARGB(255, 208, 217, 249)
                                      ],
                                      radius: 2.0,
                                      tileMode: TileMode.mirror,
                                      center: Alignment.center,
                                    ).createShader(bounds),
                                child: Text(
                                  prize.name,
                                  style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold),
                                ))))),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "${prize.quantity} lots gagnables",
                          style: const TextStyle(
                              color: TombolaColorConstants.writtenWhite,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ))),
                const Spacer(),
                AutoSizeText(
                  textAlign: TextAlign.justify,
                  prize.description ?? "Pas de description",
                  maxLines: 3,
                  style: const TextStyle(
                      color: TombolaColorConstants.writtenWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ]))
        ]));
  }
}
