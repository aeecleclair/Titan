import 'package:flutter/material.dart';
import 'package:myecl/booking/tools/constants.dart';

class StepTitle extends StatelessWidget {
  final String title;
  const StepTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: BookingColorConstants.darkBlue));
  }
}
