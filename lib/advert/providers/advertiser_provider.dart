import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

final advertiserProvider =
    StateNotifierProvider<AdvertiserNotifier, List<AdvertiserComplete>>((ref) {
  return AdvertiserNotifier();
});

class AdvertiserNotifier extends StateNotifier<List<AdvertiserComplete>> {
  AdvertiserNotifier() : super([]);

  void addAdvertiser(AdvertiserComplete i) {
    state.add(i);
    state = state.sublist(0);
  }

  void removeAdvertiser(AdvertiserComplete i) {
    state = state
        .where(
          (element) => element.id != i.id,
        )
        .toList();
  }

  void clearAdvertiser() {
    state = [];
  }
}
