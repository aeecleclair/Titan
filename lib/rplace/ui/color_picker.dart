import 'package:flutter/material.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'package:myecl/rplace/providers/pixels_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final liste_couleurs = [
  'FFffffff',
  'FFf44336',
  'FF000000',
  'FF2196f3',
  'FF9c27b0',
  'FF4caf50',
  'FFe91e63',
  'FF536dfe',
  'FF009688',
  'FFffc107',
];

class colBouton extends HookConsumerWidget {
  final double x;
  final double y;
  final String color;

  const colBouton(
      {super.key, required this.x, required this.y, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pixelListNotifier = ref.read(pixelListProvider.notifier);

    return Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: const BoxDecoration(borderRadius: null),
        child: FilledButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(int.parse(color, radix: 16)),
          ),
          onPressed: () => {
            pixelListNotifier.createPixel(
              Pixel(
                x: x,
                y: y,
                color: color,
              ),
            ),
            Navigator.pop(context)
          },
          child: null,
        ));
  }
}

class ColorPicker extends StatelessWidget {
  final double x;
  final double y;

  const ColorPicker({super.key, required this.x, required this.y});

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
                  .map(
                    (colo) => colBouton(
                      x: x,
                      y: y,
                      color: colo,
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
