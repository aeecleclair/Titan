import 'package:flutter/material.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';

class QrCode extends StatelessWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Center(
          child: CustomPaint(
            painter: QrPainter(
              data:
                  "Explicabo eos culpa hic aliquid aliquam cupiditate. Laboriosam aperiam ullam in reprehenderit. Ut et laudantium nihil sapiente dolor tenetur suscipit ut maxime. Et rem repellendus repudiandae incidunt ab natus nobis expedita temporibus. Ullam consequatur sint quasi.",
              options: const QrOptions(
                  shapes: QrShapes(
                      darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                      frame: QrFrameShapeRoundCorners(cornerFraction: .25),
                      ball: QrBallShapeRoundCorners(cornerFraction: .25)),
                  colors: QrColors(
                    background: QrColorSolid(Colors.white),
                    dark: QrColorLinearGradient(colors: [
                      Color(0xff017f80),
                      Color.fromARGB(255, 9, 103, 103),
                    ], orientation: GradientOrientation.leftDiagonal),
                  )),
            ),
            size: const Size(340, 340),
          ),
        ),
      ),
    );
  }
}
