import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/advert/class/advert.dart';

class AdvertNotifier extends StateNotifier<Advert> {
  AdvertNotifier() : super(Advert.empty());

  void setAdvert(Advert i) {
    state = i;
  }
}

final advertProvider = StateNotifierProvider<AdvertNotifier, Advert>((ref) {
  return AdvertNotifier();
});
