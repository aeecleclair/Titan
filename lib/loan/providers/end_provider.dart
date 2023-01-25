import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/tools/functions.dart';

class EndNotifier extends StateNotifier<TextEditingController> {
  EndNotifier() : super(TextEditingController());

  void setEnd(String end) {
    state.value = state.value.copyWith(
      text: end,
      selection: TextSelection.fromPosition(TextPosition(offset: end.length)),
    );
  }

  void setEndFromSelected(String start, List<Item> selected) {
    state.text = processDate(DateTime.parse(processDateBack(start)).add(
        Duration(
            days: (selected.fold<double>(
                double.infinity,
                (previousValue, element) =>
                    previousValue > element.suggestedLendingDuration
                        ? element.suggestedLendingDuration
                        : previousValue)).toInt())));
  }
}

final endProvider =
    StateNotifierProvider<EndNotifier, TextEditingController>((ref) {
  return EndNotifier();
});
