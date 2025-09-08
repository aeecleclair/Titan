import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/providers/selected_items_provider.dart';
import 'package:titan/loan/tools/functions.dart';

class NumberSelectedText extends HookConsumerWidget {
  const NumberSelectedText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItems = ref.watch(editSelectedListProvider);
    return Text(
      formatNumberItems(
        selectedItems.fold(
          0,
          (previousValue, element) => previousValue + element,
        ),
      ),
    );
  }
}
