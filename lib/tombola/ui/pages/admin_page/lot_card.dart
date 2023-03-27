import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class LotCard extends StatelessWidget {
  final Lot lot;
  final Function() onEdit;
  final Future Function() onDelete;
  final RaffleStatusType status;
  const LotCard(
      {super.key,
      required this.lot,
      required this.onEdit,
      required this.onDelete,
      required this.status});

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
            colors: [
              Color(0xff0193a5),
              Color(0xff004a59),
            ],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: TombolaColorConstants.textDark.withOpacity(0.2),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              AutoSizeText(lot.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: TombolaColorConstants.textDark)),
              const SizedBox(height: 4),
              AutoSizeText("${TombolaTextConstants.quantity} : ${lot.quantity}",
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
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  TombolaColorConstants.gradient2,
                                  TombolaColorConstants.textDark,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: TombolaColorConstants.textDark
                                        .withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(2, 3))
                              ],
                            ),
                            child: const HeroIcon(HeroIcons.pencil,
                                color: Colors.white),
                          ),
                        ),
                        ShrinkButton(
                            waitChild: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      TombolaColorConstants.redGradient1,
                                      TombolaColorConstants.redGradient2,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: TombolaColorConstants
                                            .redGradient2
                                            .withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(2, 3))
                                  ],
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )),
                            onTap: onDelete,
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    TombolaColorConstants.redGradient1,
                                    TombolaColorConstants.redGradient2,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: TombolaColorConstants.redGradient2
                                          .withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3))
                                ],
                              ),
                              child: const HeroIcon(HeroIcons.trash,
                                  color: Colors.white),
                            ))
                      ],
                    )
                  : status == RaffleStatusType.locked
                      ? Center(
                          child: ShrinkButton(
                              waitChild: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        TombolaColorConstants.gradient2,
                                        TombolaColorConstants.textDark,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: TombolaColorConstants.textDark
                                              .withOpacity(0.5),
                                          blurRadius: 10,
                                          offset: const Offset(2, 3))
                                    ],
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )),
                              onTap: onDelete,
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      TombolaColorConstants.gradient2,
                                      TombolaColorConstants.textDark,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: TombolaColorConstants.textDark
                                            .withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(2, 3))
                                  ],
                                ),
                                child: Row(
                                  children: const [
                                    HeroIcon(HeroIcons.envelopeOpen,
                                        color: Colors.white),
                                    SizedBox(width: 15),
                                    Text("Tirer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )),
                        )
                      : Expanded(
                          child: Column(
                            children: const [
                              Center(
                                  child: Text("En Attente",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              Spacer()
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
