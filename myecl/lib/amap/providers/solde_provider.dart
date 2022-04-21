import 'package:flutter_riverpod/flutter_riverpod.dart';

final soldeProvider = StateNotifierProvider<Solde, double>((ref) {
  return Solde();
});

class Solde extends StateNotifier<double> {
  Solde() : super(105.43);

  void setsolde(double i) {
    state = i;
  }
}
