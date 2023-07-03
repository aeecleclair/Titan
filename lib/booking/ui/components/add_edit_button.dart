import 'package:flutter/material.dart';

class AddEditButton extends StatelessWidget {
  final Widget child;
  const AddEditButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
