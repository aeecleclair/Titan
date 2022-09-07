import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';

class LoanCommonButton extends StatelessWidget {
  final String text;

  const LoanCommonButton({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: const [
              LoanColorConstants.veryLightOrange,
              LoanColorConstants.lightOrange,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: LoanColorConstants.veryLightOrange,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ]),
      child: Text(
        text,
        style: const TextStyle(
          color: LoanColorConstants.darkGrey,
          fontWeight: FontWeight.w700,
          fontSize: 25,
        ),
      ),
    );
  }
}
