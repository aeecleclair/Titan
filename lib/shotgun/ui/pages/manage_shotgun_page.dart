import 'package:flutter/material.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';

class ManageShotgunPage extends StatelessWidget {
  const ManageShotgunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShotgunTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gérer les shotgun de l'association",
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
