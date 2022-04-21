import 'package:flutter_riverpod/flutter_riverpod.dart';

final prixProvider = StateNotifierProvider<Prix, double>((ref) {
  return Prix();
});

class Prix extends StateNotifier<double> {
  Prix() : super(0.0);

  void setPrix(double i) {
    state = i;
  }
}
