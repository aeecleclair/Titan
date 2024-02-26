import 'package:flutter_riverpod/flutter_riverpod.dart';

final reloadProvider = StateNotifierProvider<ReloadProvider, bool>((ref) {
  return ReloadProvider();
});

class ReloadProvider extends StateNotifier<bool> {
  ReloadProvider() : super(false);

  void setStatus(bool i) {
    state = i;
  }
}
