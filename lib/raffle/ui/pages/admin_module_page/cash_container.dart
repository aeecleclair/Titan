import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/providers/cash_provider.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/user_cash_ui.dart';

class CashContainer extends HookConsumerWidget {
  const CashContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cash = ref.watch(cashProvider);
    return cash.when(
      data: (c) => Row(children: c.map((e) => UserCashUi(cash: e)).toList()),
      error: (e, s) => Text(e.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
