import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/ui/pages/raffle_page/prize_dialog.dart';

class PrizeCard extends HookConsumerWidget {
  final Prize prize;
  const PrizeCard({super.key, required this.prize});

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
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/gift.png"),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      stops: const [0, 0.3],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 8,
                        ),
                        child: AutoSizeText(
                          prize.name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
