import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class ListLogoNotifier extends MapNotifier<String, Image> {
  ListLogoNotifier() : super();
}

final listLogosProvider = StateNotifierProvider<ListLogoNotifier,
    Map<String, AsyncValue<List<Image>>?>>((ref) {
  ListLogoNotifier listLogoNotifier = ListLogoNotifier();
  return listLogoNotifier;
});
