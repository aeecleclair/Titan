import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoanAdminProvider =
    StateNotifierProvider<IsLoanAdminNotifier, bool>((ref) {
  return IsLoanAdminNotifier();
});

class IsLoanAdminNotifier extends StateNotifier<bool> {
  IsLoanAdminNotifier() : super(true);

  void setIsAdmin(bool i) {
    state = i;
  }
}
