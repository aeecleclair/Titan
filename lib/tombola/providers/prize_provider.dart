import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/prize.dart';

class PrizeNotifier extends StateNotifier<Prize> {
  PrizeNotifier() : super(Prize.empty());

  void setLot(Prize lot) {
    state = lot;
  }
}

final prizeProvider = StateNotifierProvider<PrizeNotifier, Prize>((ref) {
  return PrizeNotifier();
});
