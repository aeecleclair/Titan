import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AdvertPostersNotifier extends MapNotifier<String, Image> {
  AdvertPostersNotifier() : super();
}

final advertPostersProvider =
    StateNotifierProvider<
      AdvertPostersNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >((ref) {
      AdvertPostersNotifier advertPosterNotifier = AdvertPostersNotifier();
      return advertPosterNotifier;
    });
