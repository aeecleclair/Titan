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
        child: Container(
            width: 350,
            height: 300,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: TombolaColorConstants.darkText,
                    spreadRadius: 0,
                    blurRadius: 8,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.9),
                  ],
                  stops: const [0, 0.8],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3),
                    ),
                  ),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            prize.name,
                            style: const TextStyle(
                                color: TombolaColorConstants.darkText,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          )))),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "${prize.quantity} lots gagnables",
                        style: const TextStyle(
                            color: TombolaColorConstants.darkText,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ))),
              const Spacer(),
              AutoSizeText(
                textAlign: TextAlign.justify,
                prize.description ?? "Pas de description",
                maxLines: 3,
                style: const TextStyle(
                    color: TombolaColorConstants.darkText,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ])));
  }
}
