import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';

class LoanCommonButton extends StatelessWidget {
  final String text;

  const LoanCommonButton({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient:  const LinearGradient(
            colors: [
              LoanColorConstants.lightOrange,
              LoanColorConstants.orange,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: LoanColorConstants.lightOrange,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ]),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: LoanColorConstants.veryLightOrange,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
