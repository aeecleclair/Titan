import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/tools/constants.dart';

class PrizeDialog extends HookConsumerWidget {
  final Prize prize;
  const PrizeDialog({super.key, required this.prize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350,
        height: 300,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: RaffleColorConstants.gradient2,
              blurRadius: 15,
              blurStyle: BlurStyle.outer,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: RadialGradient(
            colors: [
              RaffleColorConstants.gradient1,
              RaffleColorConstants.gradient2,
            ],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: RaffleColorConstants.writtenWhite,
                    width: 3,
                  ),
                ),
              ),
              child: Center(
                child: AutoSizeText(
                  prize.name,
                  maxLines: 1,
                  style: const TextStyle(
                    color: RaffleColorConstants.writtenWhite,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "${prize.quantity} ${RaffleTextConstants.prize}${prize.quantity > 1 ? "s" : ""} ${RaffleTextConstants.winnable}${prize.quantity > 1 ? "s" : ""}",
                  style: const TextStyle(
                    color: RaffleColorConstants.writtenWhite,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            AutoSizeText(
              prize.description == null || prize.description!.isEmpty
                  ? RaffleTextConstants.noDescription
                  : prize.description!,
              maxLines: 4,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: RaffleColorConstants.writtenWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
