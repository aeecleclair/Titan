import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/tools/constants.dart';

class PrizeCard extends HookConsumerWidget {
  const PrizeCard({
    Key? key,
    required this.prize,
  }) : super(key: key);
  final Lot prize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PrizeDialog(prize: prize);
            },
          );
        },
        child: Container(
            width: 100,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/gift.png"),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0,
                    blurRadius: 8,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            prize.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )))),
              const SizedBox(height: 10),
            ])));
  }
}

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
                boxShadow: [
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
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3),
                    ),
                  ),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            prize.name,
                            style: TextStyle(
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
                        style: TextStyle(
                            color: TombolaColorConstants.darkText,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ))),
              const Spacer(),
              AutoSizeText(
                textAlign: TextAlign.justify,
                prize.description ?? "Pas de description",
                maxLines: 3,
                style: TextStyle(
                    color: TombolaColorConstants.darkText, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ])));
  }
}
