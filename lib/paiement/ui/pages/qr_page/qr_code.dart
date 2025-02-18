import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  const QrCode({super.key});

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
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Center(
          child: QrImageView(
            data:
                "Explicabo eos culpa hic aliquid aliquam cupiditate. Laboriosam aperiam ullam in reprehenderit. Ut et laudantium nihil sapiente dolor tenetur suscipit ut maxime. Et rem repellendus repudiandae incidunt ab natus nobis expedita temporibus. Ullam consequatur sint quasi.",
            version: QrVersions.auto,
            size: min(
              MediaQuery.of(context).size.width * 0.8,
              MediaQuery.of(context).size.height * 0.8,
            ),
            eyeStyle: const QrEyeStyle(
              color: Colors.black,
              eyeShape: QrEyeShape.square,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
