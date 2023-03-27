import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/tools/constants.dart';

class ConfirmPaymentDialog extends HookConsumerWidget {
  final TypeTicket typeTicket;
  final Raffle raffle;
  const ConfirmPaymentDialog(
      {Key? key, required this.typeTicket, required this.raffle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                            child: Image.asset("assets/images/logo.png",
                                height: 100),
                          ),
                        ),
                        Text(
                          "${typeTicket.price} €",
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
                    "${typeTicket.value} tickets",
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
                        Container(
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
                                      color:
                                          Colors.grey.shade300.withOpacity(0.5),
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
                        const Spacer(
                          flex: 3,
                        ),
                        Container(
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: const HeroIcon(HeroIcons.xMark,
                              color: Colors.white, size: 40),
                        ),
                        const Spacer(),
                      ],
                    ),
                  )
                ])));
  }
}
