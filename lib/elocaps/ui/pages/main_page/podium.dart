import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myecl/elocaps/tools/constants.dart';

class Podium extends StatelessWidget {
  const Podium(
      {Key? key, required this.rank, required this.text,this.width = 100,this.height = 30})
      : super(key: key);

  final int rank;
  final String text;
  final double? width;
  final double? height;
  
  @override
  Widget build(BuildContext context) {
    final int grisLev = 157 - 2*min(rank,75);
    final Color color = rank <= 3 ? ElocapsColorConstant.podium_color[rank-1] : Color.fromARGB(255, grisLev, grisLev, grisLev);

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
      height:  height,
      width: width,
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20,color: Colors.white)),
    );
  }
}
