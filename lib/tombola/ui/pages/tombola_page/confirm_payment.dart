import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/tools/constants.dart';

class ConfirmPaymentDialog extends HookConsumerWidget {
  final TypeTicket type_ticket;
  final Raffle raffle;
  const ConfirmPaymentDialog(
      {Key? key, required this.type_ticket, required this.raffle})
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
                    color: Color.fromARGB(191, 255, 255, 255),
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
                        horizontal: 35, vertical: 30),
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
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Center(
                            child: Image.asset("assets/images/logo.png",
                                height: 100),
                          ),
                        ),
                        Text(
                          "${type_ticket.price} €",
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
                    "${type_ticket.nbTicket} tickets",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 12),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 40, 245, 211),
                                    Color.fromARGB(255, 11, 94, 188),
                                    Color.fromARGB(255, 1, 10, 133)
                                  ],
                                  stops: [
                                    0,
                                    0.7,
                                    1
                                  ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text("Annuler",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 12),
                              margin: EdgeInsets.only(left:5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 245, 183, 40),
                                    Color.fromARGB(255, 255, 54, 34),
                                    Color.fromARGB(255, 255, 21, 0)
                                    
                                  ],
                                  stops: [
                                    0,
                                    0.7,
                                    1
                                  ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text("Confirmer la prise du billet",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))),
                    ],
                  )
                ])));
  }
}
