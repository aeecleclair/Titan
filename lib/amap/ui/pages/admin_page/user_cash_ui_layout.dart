import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/card_layout.dart';

class UserCashUiLayout extends StatelessWidget {
  final Widget child;
  const UserCashUiLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
        width: 150,
        height: 100,
        colors: const [
          AMAPColorConstants.green1,
          AMAPColorConstants.textLight,
        ],
        shadowColor: AMAPColorConstants.textDark.withOpacity(0.2),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
            child: child));
  }
}
