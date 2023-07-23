import 'package:flutter/material.dart';

class AddEditButtonLayout extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color? gradient;
  const AddEditButtonLayout(
      {super.key,
      required this.child,
      this.color = Colors.black,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [color, gradient ?? color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
            color: (gradient ?? color).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
