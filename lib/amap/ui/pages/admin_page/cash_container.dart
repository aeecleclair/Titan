import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/admin_page/user_cash_ui.dart';
import 'package:myecl/tools/ui/async_child.dart';

class CashContainer extends HookConsumerWidget {
  const CashContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cash = ref.watch(cashProvider);
    return AsyncChild(
        value: cash,
        builder: (context, cash) =>
            Row(children: cash.map((e) => UserCashUi(cash: e)).toList()),
        loaderColor: AMAPColorConstants.greenGradient2);
  }
}
