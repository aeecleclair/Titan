import 'package:flutter/material.dart';
import 'package:myecl/rplace/ui/color_picker.dart';
import 'package:myecl/rplace/class/pixels.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'my_painter.dart';

class CanvasViewer extends StatefulWidget {
  const CanvasViewer({
    Key? key,
    required this.pixels,
  }) : super(key: key);

  final List<Pixel> pixels;

  @override
  State<CanvasViewer> createState() => _CanvasViewerState();
}

class _CanvasViewerState extends State<CanvasViewer> {
  void set_color(pix, col) {
    setState(() => pixels_list[pix].color = col);
  }

  @override
  Widget build(BuildContext context) => InteractiveViewer(
        constrained: false,
        minScale: 0.2,
        maxScale: 15,
        child: SizedBox(
            width: 1920,
            height: 1080,
            child: GestureDetector(
              onTapDown: (event) {
                Future<void> future = showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ColorPicker(
                        pix: ((event.localPosition.dx) ~/ 10) * nb_colonne +
                            ((event.localPosition.dy) ~/ 10),
                        color_setter: set_color);
                  },
                );

                future.then((void value) => ());
              },
              child: CustomPaint(
                size: const Size(1920, 1080),
                painter: MyPainter(
                  pixels: widget.pixels,
                ),
              ),
            )),
      );
}
