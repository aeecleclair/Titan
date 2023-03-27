import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class TicketUI extends HookConsumerWidget {
  final TypeTicket typeTicket;
  final VoidCallback onEdit;
  final Future Function() onDelete;
  final bool showButton;
  const TicketUI(
      {Key? key,
      required this.typeTicket,
      required this.onEdit,
      required this.onDelete,
      this.showButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      Container(
        width: 130,
        height: 125,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: TombolaColorConstants.ticketback.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 3),
              ),
            ],
            color: TombolaColorConstants.ticketback,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${typeTicket.price} €",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: showButton ? 5 : 10,
            ),
            Text(
              "${typeTicket.value} tickets",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            if (showButton) const Spacer(),
            if (showButton)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                            color: Colors.grey.shade300.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const HeroIcon(HeroIcons.pencil,
                        color: TombolaColorConstants.textDark),
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
                                color: TombolaColorConstants.redGradient2
                                    .withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
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
                      child:
                          const HeroIcon(HeroIcons.trash, color: Colors.white),
                    ))
              ])
          ],
        ),
      )
    ]);
  }
}
