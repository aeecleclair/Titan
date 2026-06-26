import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class PrizeNotifier extends Notifier<PrizeSimple> {
  @override
  PrizeSimple build() => PrizeSimple.empty();

  void setPrize(PrizeSimple lot) {
    state = lot;
  }
}

final prizeProvider = NotifierProvider<PrizeNotifier, PrizeSimple>(
  PrizeNotifier.new,
);
