import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class AdvertPosterNotifier extends MapNotifier<Advert, Image> {
  AdvertPosterNotifier() : super();
}

final advertPostersProvider = StateNotifierProvider<AdvertPosterNotifier,
    Map<Advert, AsyncValue<List<Image>>?>>((ref) {
  AdvertPosterNotifier advertPosterNotifier = AdvertPosterNotifier();
  return advertPosterNotifier;
});
