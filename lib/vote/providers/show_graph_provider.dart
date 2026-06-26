import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowGraphNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle(bool p) {
    state = p;
  }
}

final showGraphProvider = NotifierProvider<ShowGraphNotifier, bool>(
  ShowGraphNotifier.new,
);
