import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

class UserCashUiLayout extends StatelessWidget {
  final Widget child;
  const UserCashUiLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: [
                  AMAPColorConstants.green1,
                  AMAPColorConstants.textLight,
                ],
                center: Alignment.topLeft,
                radius: 1.5,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AMAPColorConstants.textDark.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
                child: child)));
  }
}
