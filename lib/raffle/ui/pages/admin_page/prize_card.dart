import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/class/raffle_status_type.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class PrizeCard extends StatelessWidget {
  final Prize prize;
  final Function() onEdit;
  final Future Function() onDelete, onDraw;
  final RaffleStatusType status;
  const PrizeCard(
      {super.key,
      required this.prize,
      required this.onEdit,
      required this.onDelete,
      required this.status,
      required this.onDraw});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      width: 130,
      height: 125,
      colors: const [
        RaffleColorConstants.blueGradient1,
        RaffleColorConstants.blueGradient2
      ],
      shadowColor: RaffleColorConstants.textDark.withOpacity(0.2),
      padding: const EdgeInsets.only(left: 17.0, top: 5, right: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          AutoSizeText(prize.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RaffleColorConstants.textDark)),
          const SizedBox(height: 4),
          AutoSizeText(
              prize.quantity > 0
                  ? "${RaffleTextConstants.quantity} : ${prize.quantity}"
                  : "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const Spacer(),
          status == RaffleStatusType.creation
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: const CardButton(
                        color: RaffleColorConstants.gradient2,
                        gradient: RaffleColorConstants.textDark,
                        child: HeroIcon(HeroIcons.pencil, color: Colors.white),
                      ),
                    ),
                    WaitingButton(
                      builder: (child) => CardButton(
                          color: RaffleColorConstants.redGradient1,
                          gradient: RaffleColorConstants.redGradient2,
                          child: child),
                      onTap: onDelete,
                      child:
                          const HeroIcon(HeroIcons.trash, color: Colors.white),
                    )
                  ],
                )
              : status == RaffleStatusType.locked
                  ? prize.quantity > 0
                      ? Center(
                          child: WaitingButton(
                              builder: (child) => CardButton(
                                  color: RaffleColorConstants.gradient2,
                                  gradient: RaffleColorConstants.textDark,
                                  child: child),
                              onTap: onDraw,
                              child: const Row(
                                children: [
                                  HeroIcon(HeroIcons.envelopeOpen,
                                      color: Colors.white),
                                  SizedBox(width: 15),
                                  Text(RaffleTextConstants.draw,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        )
                      : Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 12),
                          child: const Row(
                            children: [
                              HeroIcon(HeroIcons.check, color: Colors.white),
                              SizedBox(width: 15),
                              Text(RaffleTextConstants.drawn,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                  : const Expanded(child: Loader()),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
