import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';


final advertProvider =
    StateNotifierProvider<AdvertNotifier, Advert>((ref) {
  return AdvertNotifier();
});

class AdvertNotifier extends StateNotifier<Advert> {
  AdvertNotifier() : super(Advert.empty());

  void setAdvert(Advert i) {
    state = i;
  }
}