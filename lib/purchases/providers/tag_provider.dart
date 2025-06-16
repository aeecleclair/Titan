import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagNotifier extends StateNotifier<String> {
  TagNotifier() : super("");

  void setTag(String i) {
    state = i;
  }
}

final tagProvider = StateNotifierProvider<TagNotifier, String>((ref) {
  TagNotifier notifier = TagNotifier();
  return notifier;
});
