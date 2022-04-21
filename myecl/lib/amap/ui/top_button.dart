import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

class TopButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function onclick;
  const TopButton({Key? key, required this.text, required this.selected, required this.onclick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 70,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // la couleur dépend de si on est sur la page correspondante
            colors: selected
                ? [ColorConstants.l2, ColorConstants.gradient2]
                : [Colors.transparent, Colors.transparent],
          ),
          boxShadow: [
            BoxShadow(
              // Le bouton pour aller sur la page des commandes
              color: selected
                  ? ColorConstants.gradient2.withOpacity(0.4)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              // Le bouton pour aller sur la page des commandes
              color: selected
                  ? ColorConstants.background
                  : const Color(0xff387200)),
        ),
      ),
      onTap: () {
        onclick();
      },
    );
  }
}
