import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Container(
      width: 150,
      height: 200,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              this.color.withAlpha(100),
              this.color,
              
            ],
            stops:const [0,0.8],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    )]);
  }
}
