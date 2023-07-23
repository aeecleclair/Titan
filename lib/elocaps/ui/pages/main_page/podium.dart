import 'package:flutter/material.dart';

class Podium extends StatelessWidget {
  const Podium(
      {Key? key, required this.rank, required this.text, required this.color,this.width = 100})
      : super(key: key);

  final int rank;
  final String text;
  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.5),
            color,
          ],
          center: Alignment.topLeft,
          radius: 1.5,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.all(5),
      height:  rank < 4 ? (4 - rank) * 50.0 : 30.0,
      width: width,
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20,color: Colors.white)),
    );
  }
}
