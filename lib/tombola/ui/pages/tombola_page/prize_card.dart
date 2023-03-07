import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrizeCard extends HookConsumerWidget{ 
  const PrizeCard({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return 
      Container(
        width:100,
        height: 100,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color,
                spreadRadius: 0,
                blurRadius: 8,
                blurStyle:BlurStyle.outer,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.4),
                color,
              ],
              stops: const [0, 0.8],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      );
  }
}

class RowOfPrize{ //Recois des images (ou des wiget LotsCard ? ) de Lots en arguments renvoie la Row des (3?) lots

}