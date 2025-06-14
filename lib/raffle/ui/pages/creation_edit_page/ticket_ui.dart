import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class TicketUI extends HookConsumerWidget {
  final PackTicket packTicket;
  final VoidCallback onEdit;
  final Future Function() onDelete;
  final bool showButton;
  const TicketUI({
    super.key,
    required this.packTicket,
    required this.onEdit,
    required this.onDelete,
    required this.showButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          width: 130,
          height: 125,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: RaffleColorConstants.ticketBack.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            color: RaffleColorConstants.ticketBack,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "${packTicket.price} €",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: showButton ? 5 : 10),
                  Text(
                    "${packTicket.packSize} tickets",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (showButton) const Spacer(),
              if (showButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade200,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300.withValues(
                                alpha: 0.5,
                              ),
                              blurRadius: 10,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: const HeroIcon(
                          HeroIcons.pencil,
                          color: RaffleColorConstants.textDark,
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
                ),
            ],
          ),
        ),
      ],
    );
  }
}
