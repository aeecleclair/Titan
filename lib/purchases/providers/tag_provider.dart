import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagNotifier extends Notifier<String> {
  @override
  String build() => "";

  void setTag(String i) {
    state = i;
  }
}

final tagProvider = NotifierProvider<TagNotifier, String>(TagNotifier.new);
