import 'package:flutter/material.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AdminShrinkButton extends StatelessWidget {
  final Future<void> Function() onTap;
  final String buttonText;
  const AdminShrinkButton(
      {super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ShrinkButton(
      waitChild: Container(
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
          child: const CircularProgressIndicator(
            color: Colors.white,
          )),
      onTap: onTap,
      child: Container(
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
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
