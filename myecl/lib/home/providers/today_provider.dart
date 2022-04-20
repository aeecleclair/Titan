import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Now extends StateNotifier<DateTime> {
  // 1. initialize with current time
  Now() : super(DateTime.now()) {
    // 2. create a timer that fires every second
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      // 3. update the state with the current time
      state = DateTime.now();
    });
  }

  late final Timer _timer;

  // 4. cancel the timer when finished
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

final nowProvider = StateNotifierProvider<Now, DateTime>((ref) {
  return Now();
});
