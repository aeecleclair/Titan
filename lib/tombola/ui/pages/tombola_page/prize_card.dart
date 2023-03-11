import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/lot.dart';

class PrizeCard extends HookConsumerWidget {
  const PrizeCard({
    Key? key,
    required this.prize,
  }) : super(key: key);
  final Lot prize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Colors.cyan;
    return Container(
        width: 150,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color,
                spreadRadius: 0,
                blurRadius: 8,
                blurStyle: BlurStyle.outer,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.3),
              ],
              stops: const [0, 0.8],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: color, width: 2),
                    ),
                  ),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            prize.name,
                            style: TextStyle(
                                color: color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )))),
              const SizedBox(height: 5,),
              Center(
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "${prize.quantity} lots gagnables",
                        style: TextStyle(
                            color: color,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))),
              const Spacer(),
              Text(
                textAlign: TextAlign.center,
                prize.description ?? "Pas de description",
                maxLines: 5,
                style: TextStyle(
                    color: color, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ]));
  }
}

class RowOfPrize {
  //Recois des images (ou des wiget LotsCard ? ) de Lots en arguments renvoie la Row des (3?) lots
}
