import 'package:flutter/material.dart';

final liste_couleurs = [
  Colors.white,
  Colors.red,
  Colors.black,
  Colors.blue,
  Colors.purple,
  Colors.green,
  Colors.pink,
  Colors.teal,
  Colors.amber,
  Colors.indigoAccent
];

class colBouton extends StatelessWidget {
  final Color col;
  final int pix;
  final Function color_setter;
  const colBouton(
      {super.key,
      required this.col,
      required this.pix,
      required this.color_setter});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: const BoxDecoration(borderRadius: null),
        child: FilledButton(
          style: TextButton.styleFrom(
            backgroundColor: col,
          ),
          onPressed: () => {color_setter(pix, col), Navigator.pop(context)},
          child: null,
        ));
  }
}

class ColorPicker extends StatelessWidget {
  final Function color_setter;
  final int pix;

  const ColorPicker({super.key, required this.pix, required this.color_setter});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              //children: List.generate(nb_couleurs, (i) => colBouton(px: px, col: i, func: change_color))
              children: liste_couleurs
                  .map((colo) => colBouton(
                      pix: pix, color_setter: color_setter, col: colo))
                  .toList()),
        ),
      ),
    );
  }
}
