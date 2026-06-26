import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setFilter(String i) {
    state = i;
  }
}

final filterProvider = NotifierProvider<FilterNotifier, String>(
  FilterNotifier.new,
);
