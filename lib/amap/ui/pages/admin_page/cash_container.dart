import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/providers/cash_list_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/admin_page/user_cash_ui.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class CashContainer extends HookConsumerWidget {
  const CashContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cash = ref.watch(cashListProvider);
    return AsyncChild(
      value: cash,
      builder: (context, cash) =>
          Row(children: cash.map((e) => UserCashUi(cash: e)).toList()),
      loaderColor: AMAPColorConstants.greenGradient2,
    );
  }
}
