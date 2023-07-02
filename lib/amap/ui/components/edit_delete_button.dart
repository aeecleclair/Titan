import 'package:flutter/material.dart';

class EditDeleteButton extends StatelessWidget {
  final Widget child;
  final Color gradient1;
  final Color gradient2;
  const EditDeleteButton(
      {super.key,
      required this.child,
      required this.gradient1,
      required this.gradient2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [gradient1, gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: gradient2.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 3))
        ],
      ),
      child: child,
    );
  }
}
