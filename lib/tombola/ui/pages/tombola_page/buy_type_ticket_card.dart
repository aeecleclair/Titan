import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/confirm_payment.dart';

class BuyTypeTicket extends HookConsumerWidget {
  final TypeTicket type_ticket;
  final Raffle raffle;
  const BuyTypeTicket(
      {Key? key, required this.type_ticket, required this.raffle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmPaymentDialog(raffle: raffle, type_ticket: type_ticket,);
            },
          );
        },
        child: Container(
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(231, 4, 0, 11).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(2, 3),
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(201, 2, 1, 42),
                    Color.fromARGB(241, 4, 0, 11)
                  ]),
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
                            Image.asset("assets/images/logo.png", height: 40),
                      ),
                    ),
                    Text(
                      "${type_ticket.price} €",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${type_ticket.nbTicket} tickets",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(87, 255, 255, 255),
                          blurRadius: 8,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 245, 183, 40),
                            Color.fromARGB(255, 235, 74, 25),
                            Color.fromARGB(255, 206, 39, 24)
                          ],
                          stops: [
                            0,
                            0.7,
                            1
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text("Prendre ce billet",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
            ],
          ),
        ));
  }
}
