import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Now extends StateNotifier<DateTime> {
  Now() : super(DateTime.now()) {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      state = DateTime.now();
    });
  }

  late final Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

final nowProvider = StateNotifierProvider<Now, DateTime>((ref) {
  return Now();
});
