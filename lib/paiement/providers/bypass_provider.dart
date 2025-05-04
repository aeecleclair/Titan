import 'package:hooks_riverpod/hooks_riverpod.dart';

class BypassNotifier extends StateNotifier<bool> {
  BypassNotifier() : super(false);

  void setBypass(bool bypass) {
    state = bypass;
  }
}

final bypassProvider = StateNotifierProvider<BypassNotifier, bool>((ref) {
  return BypassNotifier();
});
