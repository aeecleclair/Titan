import 'package:flutter/material.dart';
import 'package:myecl/rplace/ui/color_picker.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'my_painter.dart';
import 'package:myecl/rplace/providers/pixels_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CanvasViewer extends HookConsumerWidget {
  const CanvasViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pixels = ref.watch(pixelListProvider);

    return InteractiveViewer(
        minScale: 0.2,
        maxScale: 15,
        child: Center(
          child: GestureDetector(
            onTapDown: (event) {
              Future<void> future = showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ColorPicker(
                    x: (((event.localPosition.dx) ~/ 10) * 10 + 5).toDouble(),
                    y: (((event.localPosition.dy) ~/ 10) * 10 + 5).toDouble(),
                  );
                },
              );

              future.then((void value) => ());
            },
            child: AsyncChild(
                value: pixels,
                builder: (context, pixels) {
                  return CustomPaint(
                    size: Size(
                        10 * nb_ligne.toDouble(), 10 * nb_colonne.toDouble()),
                    painter: MyPainter(
                      pixels: pixels,
                    ),
                  );
                }),
          ),
        ));
  }
}
