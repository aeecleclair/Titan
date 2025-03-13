import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class AdvertNotifier extends StateNotifier<AdvertReturnComplete> {
  AdvertNotifier() : super(EmptyModels.empty<AdvertReturnComplete>());

  void setAdvert(AdvertReturnComplete i) {
    state = i;
  }
}

final advertProvider =
    StateNotifierProvider<AdvertNotifier, AdvertReturnComplete>((ref) {
  return AdvertNotifier();
});
