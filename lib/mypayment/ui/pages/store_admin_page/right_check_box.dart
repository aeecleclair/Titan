import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/seller_rights_list_providder.dart';

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
    return CheckboxListTile(
      title: Text(title),
      value: sellerRightsList[index],
      activeColor: const Color(0xff204550),
      onChanged: (value) {
        sellerRightsListNotifier.updateRights(index, value ?? false);
      },
    );
  }
}
