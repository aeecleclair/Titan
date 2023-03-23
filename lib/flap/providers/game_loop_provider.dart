import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<Timer?> {
  TimerNotifier() : super(null);

  void stop() {
    if (state != null) {
      state!.cancel();
    }
  }

  void restart(void Function(Timer) callback) {
    if (state != null) state!.cancel();
    state = Timer.periodic(const Duration(milliseconds: 10), callback);
  }

  void start(void Function(Timer) callback) {
    state = Timer.periodic(const Duration(milliseconds: 10), callback);
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Timer?>((ref) {
  return TimerNotifier();
});
