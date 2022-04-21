import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';


/// Le fenêtre de confirmation
class CustomDialogBox extends StatefulWidget {
  /// Le titre et la description de la fenêtre
  final String title, descriptions;
  /// La fonction à lancer si on clique sur "Oui"
  final Function() onYes;
  /// Les constantes d'espacement
  static const double _padding = 20;
  static const double _avatarRadius = 45;
  /// la couleur de fond
  static const Color background = Color(0xfffafafa);

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.onYes})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}


class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CustomDialogBox._padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // Eloigner les éléments du bord
          padding: const EdgeInsets.all(CustomDialogBox._padding),
          // Eloigne le conteneur du bord
          margin: const EdgeInsets.only(top: CustomDialogBox._avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: CustomDialogBox.background,
              borderRadius: BorderRadius.circular(CustomDialogBox._padding),
              // L'ombre derrière le conteneur
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade700,
                    offset: const Offset(0, 5),
                    blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              // Le titre de la fenêtre
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textDark
                ),
              ),

              // Espace entre le titre et la description
              const SizedBox(
                height: 15,
              ),
              // La description
              Text(
                widget.descriptions,
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorConstants.enabled,
                ),
                textAlign: TextAlign.center,
              ),

              // Espace entre la description et les boutons
              const SizedBox(
                height: 22,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      // Le bouton "Non"
                      TextButton(

                        // On ferme juste la fenêtre si on clique dessus
                        onPressed: () {
                          Navigator.of(context).pop();
                        },

                        // Le texte sur le bouton
                        child: const Text(
                          "Non",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.gradient2),
                        )
                      ),

                      // Le bouton "Oui"
                      TextButton(

                        // On lance la fonction donnée et on ferme la fenêtre si on clique dessus
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onYes();
                        },

                        // Le texte sur le bouton
                        child: const Text(
                          "Oui",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.redGradient1
                          ),
                        )
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
