import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class SessionLogoNotifier extends MapNotifier<String, Image> {}

final sessionPosterMapProvider =
    NotifierProvider<
      SessionLogoNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >(() => SessionLogoNotifier());
