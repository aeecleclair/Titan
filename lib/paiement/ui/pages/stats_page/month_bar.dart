import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MonthBar extends HookConsumerWidget {
  final DateTime currentMonth;
  const MonthBar({super.key, required this.currentMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      DateFormat("MMMM yyyy", "fr_FR").format(currentMonth),
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
