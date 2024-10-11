import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberDayProvider = StateNotifierProvider<NumberDay, int>((ref) {
  return NumberDay();
});

class NumberDay extends StateNotifier<int> {
  NumberDay() : super(30);

  void add(int i) {
    state += i;
  }
}
