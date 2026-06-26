import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = NotifierProvider<FilterNotifier, String>(
  FilterNotifier.new,
);

class FilterNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setFilter(String i) {
    state = i;
  }
}
