import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';

class TagNotifier extends StateNotifier<String> {
  TagNotifier({required String token}) : super("");

  void setTag(String i) {
    state = i;
  }
}

final tagProvider = StateNotifierProvider<TagNotifier, String>((ref) {
  final token = ref.watch(tokenProvider);
  TagNotifier notifier = TagNotifier(token: token);
  return notifier;
});
