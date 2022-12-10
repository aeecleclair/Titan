import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionsStatsNotifier extends MapNotifier<Section, int> {
  SectionsStatsNotifier({required super.token});
}

final sectionsStatsProvider = StateNotifierProvider<SectionsStatsNotifier,
    AsyncValue<Map<Section, AsyncValue<List<int>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final sections = ref.watch(sectionsProvider);
  SectionsStatsNotifier sectionsStatsNotifier =
      SectionsStatsNotifier(token: token);
  sections.whenData((value) {
    sectionsStatsNotifier.loadTList(value);
  });
  return sectionsStatsNotifier;
});
