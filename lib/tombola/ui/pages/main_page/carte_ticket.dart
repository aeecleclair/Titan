import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        margin:const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
              BoxShadow(
                color: this.color.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(4, 4), // changes position of shadow
              ),
            ],

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                this.color.withOpacity(0.4),
                this.color,
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        );
  }
}
