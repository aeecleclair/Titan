import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/tools/functions.dart';

class TombolaCard extends HookConsumerWidget {
  final Raffle raffle;
  const TombolaCard({Key? key, required this.raffle}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: [
                  RaffleColorConstants.gradient1,
                  RaffleColorConstants.gradient2,
                ],
                center: Alignment.topLeft,
                radius: 1.5,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: RaffleColorConstants.textDark.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    AutoSizeText(raffle.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 5),
                    AutoSizeText(raffle.group.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: RaffleColorConstants.textDark)),
                    const SizedBox(height: 5),
                    AutoSizeText(
                        raffleStatusTypeToString(raffle.raffleStatusType),
                        maxLines: 1,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 10),
                  ],
                ))));
  }
}
