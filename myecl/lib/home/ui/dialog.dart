import 'package:flutter/material.dart';


// Le fenêtre de confirmation
class CustomDialogBox extends StatefulWidget {
  // Le titre et la description de la fenêtre
  final String title, descriptions;
  // La fonction à lancer si on clique sur "Oui"
  final Function() onYes;
  static const double padding = 20;
  static const double avatarRadius = 45;
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
        borderRadius: BorderRadius.circular(CustomDialogBox.padding),
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
          padding: const EdgeInsets.only(
              left: CustomDialogBox.padding,
              top: CustomDialogBox.padding,
              right: CustomDialogBox.padding,
              bottom: CustomDialogBox.padding),
          // Eloigne le conteneur du bord
          margin: const EdgeInsets.only(top: CustomDialogBox.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: CustomDialogBox.background,
              borderRadius: BorderRadius.circular(CustomDialogBox.padding),
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
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade800
                ),
              ),
              // Espace entre le titre et la description
              const SizedBox(
                height: 15,
              ),
              // La description
              Text(
                widget.descriptions,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
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
                        child: Text(
                          "Non",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red.shade700),
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
                        child: Text(
                          "Oui",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green.shade700
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
