import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class PrizeNotifier extends StateNotifier<PrizeSimple> {
  PrizeNotifier() : super(PrizeSimple.fromJson({}));

  void setPrize(PrizeSimple lot) {
    state = lot;
  }
}

final prizeProvider = StateNotifierProvider<PrizeNotifier, PrizeSimple>((ref) {
  return PrizeNotifier();
});
