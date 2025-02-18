import 'package:flutter/material.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';

class Qrcode extends StatelessWidget {
  const Qrcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: QrPainter(
          data:
              "Explicabo eos culpa hic aliquid aliquam cupiditate. Laboriosam aperiam ullam in reprehenderit. Ut et laudantium nihil sapiente dolor tenetur suscipit ut maxime. Et rem repellendus repudiandae incidunt ab natus nobis expedita temporibus. Ullam consequatur sint quasi.",
          options: QrOptions(
              shapes: const QrShapes(
                  darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                  frame: QrFrameShapeRoundCorners(cornerFraction: .25),
                  ball: QrBallShapeRoundCorners(cornerFraction: .25)),
              colors: QrColors(
                background: QrColorSolid(Colors.grey.shade50),
                dark: const QrColorLinearGradient(colors: [
                  Color(0xff017f80),
                  Color.fromARGB(255, 9, 103, 103),
                ], orientation: GradientOrientation.leftDiagonal),
              )),
        ),
        size: const Size(350, 350),
      ),
    );
  }
}
