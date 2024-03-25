import 'package:flutter/material.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PastPhSelectionPage extends StatelessWidget {
  const PastPhSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhTemplate(
        child: Column(children: [
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          QR.to(PhRouter.root + PhRouter.past_ph_selection + PhRouter.past_ph);
        },
        child: const MyButton(
          text: "Journal de février 2023",
        ),
      ),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          QR.to(PhRouter.root + PhRouter.past_ph_selection + PhRouter.past_ph);
        },
        child: const MyButton(
          text: "Journal de janvier 2023",
        ),
      ),
    ]));
  }
}
