import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 70, height: 70),
            const SizedBox(width: 20),
            const Text('MyECL',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(width: 15),
            const Text("-",
                style: TextStyle(fontSize: 25, color: Colors.black)),
            const SizedBox(width: 15),
            const Expanded(
              child: AutoSizeText("L'application de l'associatif centralien",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
