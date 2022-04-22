import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAmountProvider = StateNotifierProvider<UserAmountNotifier, double>((ref) {
  return UserAmountNotifier();
});

class UserAmountNotifier extends StateNotifier<double> {
  UserAmountNotifier() : super(105.43);

  void setUserAmount(double i) {
    state = i;
  }
}
