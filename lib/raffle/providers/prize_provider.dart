import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/class/prize.dart';

class PrizeNotifier extends StateNotifier<Prize> {
  PrizeNotifier() : super(Prize.empty());

  void setPrize(Prize lot) {
    state = lot;
  }
}

final prizeProvider = StateNotifierProvider<PrizeNotifier, Prize>((ref) {
  return PrizeNotifier();
});
