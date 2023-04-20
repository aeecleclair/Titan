import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/pack_ticket.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/user_amount_provider.dart';
import 'package:myecl/tombola/providers/user_tickets_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class ConfirmPaymentDialog extends HookConsumerWidget {
  final PackTicket packTicket;
  final Raffle raffle;
  const ConfirmPaymentDialog(
      {Key? key, required this.packTicket, required this.raffle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAmount = ref.watch(userAmountProvider);
    final userAmountNotifier = ref.watch(userAmountProvider.notifier);
    final userTicketListNotifier = ref.watch(userTicketListProvider.notifier);

    double b = 0;
    userAmount.when(
        data: (u) {
          b = u.balance;
        },
        error: (e, s) {},
        loading: () {});

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    void navigationPop() {
      Navigator.pop(context);
    }

    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 300,
            height: 450,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: TombolaColorConstants.gradient2,
                    blurRadius: 15,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: RadialGradient(colors: [
                  TombolaColorConstants.gradient1,
                  TombolaColorConstants.gradient2,
                ], center: Alignment.topLeft, radius: 1.5)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  blurRadius: 15,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: Center(
                            child: Image.asset("assets/images/soli.png",
                                height: 80),
                          ),
                        ),
                        Text(
                          "${packTicket.price} €",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${packTicket.packSize} tickets",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AutoSizeText(
                        raffle.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        ShrinkButton(
                          waitChild: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade100,
                                      Colors.grey.shade200,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300
                                            .withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(2, 3))
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: TombolaColorConstants.textDark,
                                ),
                              )),
                          onTap: () async {
                            if (b < packTicket.price) {
                              displayToastWithContext(TypeMsg.error,
                                  "Vous n'avez pas assez d'argent");
                            } else {
                              await tokenExpireWrapper(ref, () async {
                                final value = await userTicketListNotifier
                                    .buyTicket(packTicket);
                                if (value) {
                                  userAmountNotifier
                                      .updateCash(-packTicket.price.toDouble());
                                  displayToastWithContext(TypeMsg.msg,
                                      TombolaTextConstants.boughtTicket);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      TombolaTextConstants.addingError);
                                }
                                navigationPop();
                              });
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade100,
                                      Colors.grey.shade200,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300
                                            .withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(2, 3))
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: const HeroIcon(
                                HeroIcons.check,
                                color: TombolaColorConstants.textDark,
                                size: 40,
                              )),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigationPop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    TombolaColorConstants.redGradient1,
                                    TombolaColorConstants.redGradient2,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: TombolaColorConstants.redGradient2
                                          .withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3))
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: const HeroIcon(HeroIcons.xMark,
                                color: Colors.white, size: 40),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  )
                ])));
  }
}
