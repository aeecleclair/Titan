import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/tools/functions.dart';

class EndNotifier extends StateNotifier<String> {
  EndNotifier() : super("");

  void setEnd(String end) {
    state = end;
  }

  void setEndFromSelected(String start, List<Item> selected) {
    state = processDate(
      DateTime.parse(processDateBack(start)).add(
        Duration(
          days: (selected.fold<int>(
            9223372036854775807, //maxInt does not have constant value like double
            (previousValue, element) =>
                previousValue > element.suggestedLendingDuration
                    ? element.suggestedLendingDuration
                    : previousValue,
          )).toInt(),
        ),
      ),
    );
  }
}

final endProvider = StateNotifierProvider<EndNotifier, String>((ref) {
  return EndNotifier();
});
