import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/class/raffle_status_type.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/raffle_page/confirm_payment.dart';

class BuyTypeTicketSimple extends HookConsumerWidget {
  final TypeTicketSimple typeTicket;
  final Raffle raffle;
  const BuyTypeTicketSimple(
      {super.key, required this.typeTicket, required this.raffle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          if (raffle.raffleStatusType == RaffleStatusType.open) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmPaymentDialog(
                  typeTicket: typeTicket,
                  raffle: raffle,
                );
              },
            );
          }
        },
        child: Container(
          width: 160,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(231, 4, 0, 11).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(2, 3),
                ),
              ],
              gradient: const RadialGradient(colors: [
                RaffleColorConstants.gradient1,
                RaffleColorConstants.gradient2,
              ], center: Alignment.topLeft, radius: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(1, 2),
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child:
                            Image.asset("assets/images/soli.png", height: 40),
                      ),
                    ),
                    Text(
                      "${typeTicket.price.toStringAsFixed(2)}€",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${typeTicket.packSize} ${RaffleTextConstants.ticket}${typeTicket.packSize > 1 ? "s" : ""}",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors:
                              raffle.raffleStatusType != RaffleStatusType.open
                                  ? [
                                      RaffleColorConstants.redGradient1,
                                      RaffleColorConstants.redGradient2,
                                    ]
                                  : [Colors.white, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          raffle.raffleStatusType == RaffleStatusType.open
                              ? RaffleTextConstants.buyThisTicket
                              : raffle.raffleStatusType ==
                                      RaffleStatusType.locked
                                  ? RaffleTextConstants.lockedRaffle
                                  : RaffleTextConstants.unavailableRaffle,
                          style: TextStyle(
                              color: raffle.raffleStatusType !=
                                      RaffleStatusType.open
                                  ? Colors.white
                                  : RaffleColorConstants.gradient2,
                              fontWeight: FontWeight.bold)))),
            ],
          ),
        ));
  }
}
