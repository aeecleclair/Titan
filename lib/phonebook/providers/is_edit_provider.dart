import 'package:flutter_riverpod/flutter_riverpod.dart';

final isEditProvider = StateNotifierProvider<IsEditProvider, bool>((ref) {
  return IsEditProvider();
});

class IsEditProvider extends StateNotifier<bool> {
  IsEditProvider() : super(false);

  void setStatus(bool i) {
    state = i;
  }
}
