import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setDate(DateTime date) {
    state = date;
  }
}

final initialDateProvider = NotifierProvider<InitialDateNotifier, DateTime>(
  () => InitialDateNotifier(),
);
