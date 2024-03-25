import 'package:flutter/material.dart';
import 'package:myecl/ph/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhMainPage extends StatelessWidget {
  const PhMainPage({super.key});

  @override
  GestureDetector build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        QR.to(PhRouter.root + PhRouter.last_ph);
      },
      child: Container(
        color: Colors.blue,
        child: const Center(
          child: Text('Open PDF'),
        ),
      ),
    );
  }
}
