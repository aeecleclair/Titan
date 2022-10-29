import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberDayProvider = StateNotifierProvider<NumberDay, int>((ref) {
  return NumberDay();
});

class NumberDay extends StateNotifier<int> {
  NumberDay() : super(15);

  void add(int i) {
    state += i;
  }
}
