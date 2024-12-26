import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/cash_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/admin_page/user_cash_ui.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/providers/theme_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class CashContainer extends HookConsumerWidget {
  const CashContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cash = ref.watch(cashListProvider);
    final isDarkTheme = ref.watch(themeProvider);
    return AsyncChild(
      value: cash,
      builder: (context, cash) =>
          Row(children: cash.map((e) => UserCashUi(cash: e)).toList()),
      loaderColor: AMAPColors(isDarkTheme).greenGradientSecondary,
    );
  }
}
