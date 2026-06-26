import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setStart(String start) {
    state = start;
  }
}

final startProvider = NotifierProvider<StartNotifier, String>(
  StartNotifier.new,
);
