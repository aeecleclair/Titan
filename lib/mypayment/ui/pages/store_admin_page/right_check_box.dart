import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/seller_rights_list_providder.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class RightCheckBox extends ConsumerWidget {
  final int index;
  final String title;
  const RightCheckBox({super.key, required this.index, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerRightsList = ref.watch(sellerRightsListProvider);
    final sellerRightsListNotifier = ref.watch(
      sellerRightsListProvider.notifier,
    );
    final isDarkTheme = ref.watch(themeProvider);
    return CheckboxListTile(
      title: Text(title),
      value: sellerRightsList[index],
      activeColor: MyPaymentColors(isDarkTheme).secondaryGreen,
      onChanged: (value) {
        sellerRightsListNotifier.updateRights(index, value ?? false);
      },
    );
  }
}
