import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/type_ticket.dart';

class BuyTypeTicket extends HookConsumerWidget {
  final TypeTicket type_ticket;
  final Raffle raffle;
  const BuyTypeTicket(
      {Key? key, required this.type_ticket, required this.raffle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Color.fromARGB(231, 33, 0, 0);
    return Container(
      width: 150,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                        offset: const Offset(2, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Image.asset("assets/images/logo.png", height: 40),
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
          SizedBox(height: 5),
          Text(
            "${type_ticket.nbTicket} tickets",
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text("+",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
}
