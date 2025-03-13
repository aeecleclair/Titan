import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class PrizeNotifier extends StateNotifier<PrizeSimple> {
  PrizeNotifier() : super(EmptyModels.empty<PrizeSimple>());

  void setPrize(PrizeSimple lot) {
    state = lot;
  }
}

final prizeProvider = StateNotifierProvider<PrizeNotifier, PrizeSimple>((ref) {
  return PrizeNotifier();
});
