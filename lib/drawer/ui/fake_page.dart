import 'package:flutter/material.dart';
import 'package:titan/drawer/tools/constants.dart';

class FakePage extends StatelessWidget {
  const FakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 50),
      width: MediaQuery.of(context).size.width - 220,
      height: 420,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: DrawerColorConstants.fakePageShadow,
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: DrawerColorConstants.fakePageBlue,
      ),
    );
  }
}
