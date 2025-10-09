import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/tools/functions.dart';

class EndNotifier extends StateNotifier<String> {
  EndNotifier() : super("");

  void setEnd(String end) {
    state = end;
  }

  void setEndFromSelected(String start, List<Item> selected) {
    state = processDate(
      DateTime.parse(processDateBack(start)).add(
        Duration(
          days: selected
              .map((item) => item.suggestedLendingDuration)
              .reduce(min),
        ),
      ),
    );
  }
}

final endProvider = StateNotifierProvider<EndNotifier, String>((ref) {
  return EndNotifier();
});
