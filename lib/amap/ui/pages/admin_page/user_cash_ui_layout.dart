import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

class UserCashUiLayout extends ConsumerWidget {
  final Widget child;
  const UserCashUiLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return CardLayout(
      width: 150,
      height: 100,
      colors: [
        AMAPColors(isDarkTheme).primaryFixedGreen,
        AMAPColors(isDarkTheme).textOnSecondary
      ],
      shadowColor: AMAPColors(isDarkTheme).textOnPrimary.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
      child: child,
    );
  }
}
