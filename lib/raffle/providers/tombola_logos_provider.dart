import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class TombolaLogosNotifier extends MapNotifier<String, Image> {
  TombolaLogosNotifier() : super();
}

final tombolaLogosProvider =
    StateNotifierProvider<
      TombolaLogosNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >((ref) {
      TombolaLogosNotifier tombolaLogosNotifier = TombolaLogosNotifier();
      return tombolaLogosNotifier;
    });
