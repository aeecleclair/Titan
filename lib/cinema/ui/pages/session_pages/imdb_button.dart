import 'package:flutter/material.dart';

class ImdbButton extends StatelessWidget {
  final Widget child;
  const ImdbButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffe2b616),
      ),
      child: child,
    );
  }
}
