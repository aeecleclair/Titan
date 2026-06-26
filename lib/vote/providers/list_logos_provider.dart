import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class ListLogoNotifier extends MapNotifier<String, Image> {
  ListLogoNotifier() : super();
}

final listLogosProvider =
    NotifierProvider<ListLogoNotifier, Map<String, AsyncValue<List<Image>>?>>(
      ListLogoNotifier.new,
    );
