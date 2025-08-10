import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class EventActionAdmin extends StatelessWidget {
  const EventActionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            width: 100,
            decoration: BoxDecoration(
              color: ColorConstants.tertiary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorConstants.onTertiary, width: 2),
            ),
            child: Center(
              child: Text(
                "Modifier",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.background,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Action button
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            width: 100,
            decoration: BoxDecoration(
              color: ColorConstants.main,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorConstants.onMain, width: 2),
            ),
            child: Center(
              child: Text(
                "Supprimer",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.background,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
