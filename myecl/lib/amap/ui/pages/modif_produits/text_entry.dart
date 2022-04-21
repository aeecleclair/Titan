import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

/// La zone pour entrer du texte
class TextEntry extends StatelessWidget {
  /// La fonction de validation du texte
  final Function validator, onChanged;

  /// le controlleur de texte, qui permet d'accéder au texte dans modif_produit.dart
  final TextEditingController textEditingController;

  /// le type de clavier
  final TextInputType keyboardType;

  // Si il doit être accessible
  final bool enabled;

  /// Initialisation
  const TextEntry(
      {Key? key,
      required this.validator,
      required this.textEditingController,
      required this.keyboardType,
      required this.onChanged,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: TextFormField(
        // La fonction de validation
        validator: ((value) {
          return validator(value);
        }),
        onChanged: (_) {
          onChanged(_);
        },
        enabled: enabled,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        controller: textEditingController,
        cursorColor: ColorConstants.enabled,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          // La forme de la bordure de la zone
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          // La couleur de la bordure
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
                  const BorderSide(color: ColorConstants.enabled)),
          // La couleur de la bordure en cas d'erreur
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 201, 23, 23))),
          // La couleur de la bordure quand on sélectionne la zone
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: ColorConstants.gradient2,
              )),
        ),
      ),
    );
  }
}
