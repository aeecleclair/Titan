import 'package:flutter/material.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';

class CreateShotgunQuotasPage extends StatelessWidget {
  const CreateShotgunQuotasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShotgunTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quotas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
