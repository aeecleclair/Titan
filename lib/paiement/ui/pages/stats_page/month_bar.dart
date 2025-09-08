import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';

class MonthBar extends HookConsumerWidget {
  final DateTime currentMonth;
  const MonthBar({super.key, required this.currentMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final history = ref.watch(myHistoryProvider);
    int total = 0;
    history.maybeWhen(
      orElse: () => total = 0,
      data: (history) {
        final confirmedTransaction = history.where(
          (element) =>
              (element.status == TransactionStatus.confirmed ||
                  element.status == TransactionStatus.refunded) &&
              element.creation.year == currentMonth.year &&
              element.creation.month == currentMonth.month,
        );
        total = confirmedTransaction.fold<int>(
          0,
          (previousValue, element) =>
              previousValue +
              (element.type == HistoryType.given
                  ? -element.total
                  : element.type == HistoryType.refundDebited
                  ? -element.total + element.refund!.total
                  : element.total),
        );
      },
    );
    return Text(
      "${DateFormat("MMMM yyyy", "fr_FR").format(currentMonth)} : ${total > 0 ? "+" : ""}${formatter.format(total / 100)} €",
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
