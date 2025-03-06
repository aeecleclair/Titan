import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class SimpleGroupLogoNotifier extends MapNotifier<CoreGroupSimple, Image> {
  SimpleGroupLogoNotifier() : super();
}

final allGroupLogosProvider = StateNotifierProvider<SimpleGroupLogoNotifier,
    Map<CoreGroupSimple, AsyncValue<List<Image>>?>>((ref) {
  SimpleGroupLogoNotifier simpleGroupLogoNotifier = SimpleGroupLogoNotifier();
  return simpleGroupLogoNotifier;
});
