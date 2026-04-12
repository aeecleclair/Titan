import 'package:flutter/material.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class UserCashUiLayout extends StatelessWidget {
  final Widget child;
  const UserCashUiLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      width: 150,
      height: 110,
      colors: const [AMAPColorConstants.green1, AMAPColorConstants.textLight],
      shadowColor: AMAPColorConstants.textDark.withValues(alpha: 0.2),
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
      child: child,
    );
  }
}
