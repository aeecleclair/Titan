import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/lot.dart';

class LotNotifier extends StateNotifier<Lot> {
  LotNotifier() : super(Lot.empty());

  void setLot(Lot lot) {
    state = lot;
  }
}

final lotProvider = StateNotifierProvider<LotNotifier, Lot>((ref) {
  return LotNotifier();
});
