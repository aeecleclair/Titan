import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class AdvertNotifier extends StateNotifier<AdvertReturnComplete> {
  AdvertNotifier() : super(AdvertReturnComplete.fromJson({}));

  void setAdvert(AdvertReturnComplete i) {
    state = i;
  }
}

final advertProvider = StateNotifierProvider<AdvertNotifier, AdvertReturnComplete>((ref) {
  return AdvertNotifier();
});
