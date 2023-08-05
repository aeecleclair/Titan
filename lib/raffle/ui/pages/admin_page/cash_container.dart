import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/providers/cash_provider.dart';
import 'package:myecl/raffle/ui/pages/admin_page/user_cash_ui.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class CashContainer extends HookConsumerWidget {
  const CashContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cash = ref.watch(cashProvider);
    return AsyncChild(
      value: cash,
      builder: (context, data) =>
          Row(children: data.map((e) => UserCashUi(cash: e)).toList()),
    );
  }
}