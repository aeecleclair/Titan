import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';


/// Le bouton vert (ce n'est pas un bouton, il doit être contenu dans un GestureDectector)
class GreenBtn extends StatelessWidget {

  /// le texte du bouton
  final String text;

  /// Initialisation
  const GreenBtn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        // Le bouton prend 65 % de la largeur de l'écran
        width: MediaQuery.of(context).size.width * 0.65,
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [ColorConstants.gradient1, ColorConstants.gradient2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
                color: ColorConstants.gradient2.withOpacity(0.4),
                offset: const Offset(2, 3),
                blurRadius: 5)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorConstants.background),
        ),
      ),
    );
  }
}
