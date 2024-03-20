import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/item_quantities_provider.dart';
import 'package:myecl/loan/tools/functions.dart';

class NumberSelectedText extends HookConsumerWidget {
  const NumberSelectedText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanItemQuantities = ref.watch(loanItemQuantitiesMapProvider);
    return Text(
      formatNumberItems(
        loanItemQuantities.values.sum,
      ),
    );
  }
}
