import 'package:flutter/material.dart';

class AssoButton extends StatelessWidget {
  final Widget child;
  final Color gradient1;
  final Color gradient2;
  const AssoButton({super.key, required this.child, required this.gradient1, required this.gradient2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradient1,
            gradient2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient2.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child
    );
  }

}