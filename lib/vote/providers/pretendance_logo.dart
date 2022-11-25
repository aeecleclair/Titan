import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/vote/class/section.dart';

class PretendanceLogoNotifier extends MapNotifier<Section, Image> {
  PretendanceLogoNotifier({required String token}) : super(token: token);
}

final pretendanceLogosProvider = StateNotifierProvider<PretendanceLogoNotifier,
    AsyncValue<Map<Section, AsyncValue<List<Image>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  PretendanceLogoNotifier pretendanceLogoNotifier =
      PretendanceLogoNotifier(token: token);
  pretendanceLogoNotifier.loadTList([]);
  return pretendanceLogoNotifier;
});
