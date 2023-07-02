import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/prize.dart';

class LotNotifier extends StateNotifier<Prize> {
  LotNotifier() : super(Prize.empty());

  void setPrize(Prize lot) {
    state = lot;
  }
}

final prizeProvider = StateNotifierProvider<LotNotifier, Prize>((ref) {
  return LotNotifier();
});
