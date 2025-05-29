import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class SimpleGroupLogoNotifier extends MapNotifier<SimpleGroup, Image> {
  SimpleGroupLogoNotifier() : super();
}

final allGroupLogosProvider =
    StateNotifierProvider<
      SimpleGroupLogoNotifier,
      Map<SimpleGroup, AsyncValue<List<Image>>?>
    >((ref) {
      SimpleGroupLogoNotifier simpleGroupLogoNotifier =
          SimpleGroupLogoNotifier();
      return simpleGroupLogoNotifier;
    });
