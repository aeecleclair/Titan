import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialDateNotifier extends StateNotifier<DateTime> {
  InitialDateNotifier() : super(DateTime.now());

  void setDate(DateTime date) {
    state = date;
  }
}

final initialDateProvider =
    StateNotifierProvider<InitialDateNotifier, DateTime>((ref) {
      return InitialDateNotifier();
    });
