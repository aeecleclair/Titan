import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class PrizeCard extends StatelessWidget {
  final Prize lot;
  final Function() onEdit;
  final Future Function() onDelete, onDraw;
  final RaffleStatusType status;
  const PrizeCard({
    super.key,
    required this.lot,
    required this.onEdit,
    required this.onDelete,
    required this.status,
    required this.onDraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 130,
        height: 125,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [Color(0xff0193a5), Color(0xff004a59)],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: RaffleColorConstants.textDark.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 17.0, top: 5, right: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              AutoSizeText(
                lot.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RaffleColorConstants.textDark,
                ),
              ),
              const SizedBox(height: 4),
              AutoSizeText(
                lot.quantity > 0
                    ? "${RaffleTextConstants.quantity} : ${lot.quantity}"
                    : "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              status == RaffleStatusType.creation
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  RaffleColorConstants.gradient2,
                                  RaffleColorConstants.textDark,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: RaffleColorConstants.textDark
                                      .withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: const HeroIcon(
                              HeroIcons.pencil,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        WaitingButton(
                          builder: (child) => Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  RaffleColorConstants.redGradient1,
                                  RaffleColorConstants.redGradient2,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: RaffleColorConstants.redGradient2
                                      .withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: child,
                          ),
                          onTap: onDelete,
                          child: const HeroIcon(
                            HeroIcons.trash,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : status == RaffleStatusType.lock
                  ? lot.quantity > 0
                        ? Center(
                            child: WaitingButton(
                              builder: (child) => Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      RaffleColorConstants.gradient2,
                                      RaffleColorConstants.textDark,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: RaffleColorConstants.textDark
                                          .withValues(alpha: 0.5),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3),
                                    ),
                                  ],
                                ),
                                child: child,
                              ),
                              onTap: onDraw,
                              child: const Row(
                                children: [
                                  HeroIcon(
                                    HeroIcons.envelopeOpen,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "Tirer",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 12,
                            ),
                            child: const Row(
                              children: [
                                HeroIcon(HeroIcons.check, color: Colors.white),
                                SizedBox(width: 15),
                                Text(
                                  "Tiré",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                  : const Expanded(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "En Attente",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
