import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class StoreDivider extends ConsumerWidget {
  final String name;
  const StoreDivider({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: MyPaymentColors(isDarkTheme).backgroundGradient2,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: MyPaymentColors(isDarkTheme).backgroundGradient2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: MyPaymentColors(isDarkTheme).backgroundGradient2,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
