import 'package:flutter/material.dart';

class ButtonState {
  final String text;
  final bool disabled;
  final VoidCallback onTap;

  const ButtonState(
      {required this.text, required this.onTap, this.disabled = false});
}

class BottomButton extends StatelessWidget {
  final ButtonState buttonState;
  const BottomButton({super.key, required this.buttonState});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!buttonState.disabled) {
          buttonState.onTap();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: buttonState.disabled
                ? const Color.fromARGB(255, 55, 76, 94)
                : const Color(0xff09263D),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            buttonState.text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
