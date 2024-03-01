import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/vote/class/contender.dart';

class ContenderLogoNotifier extends MapNotifier<Contender, Image> {
  ContenderLogoNotifier() : super();
}

final contenderLogosProvider = StateNotifierProvider<ContenderLogoNotifier,
    Map<Contender, AsyncValue<List<Image>>?>>((ref) {
  ContenderLogoNotifier contenderLogoNotifier = ContenderLogoNotifier();
  return contenderLogoNotifier;
});
