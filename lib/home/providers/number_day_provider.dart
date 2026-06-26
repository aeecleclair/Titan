import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberDay extends Notifier<int> {
  @override
  int build() {
    return 30;
  }

  void add(int i) {
    state += i;
  }
}

final numberDayProvider = NotifierProvider<NumberDay, int>(NumberDay.new);
