import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AdvertPostersNotifier extends MapNotifier<String, Image> {}

final advertPostersProvider =
    NotifierProvider<
      AdvertPostersNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >(() => AdvertPostersNotifier());
