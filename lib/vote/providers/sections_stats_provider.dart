import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionsStatsNotifier extends MapNotifier<Section, int> {
  SectionsStatsNotifier();
}

final sectionsStatsProvider = StateNotifierProvider<SectionsStatsNotifier,
    AsyncValue<Map<Section, AsyncValue<List<int>>?>>>((ref) {
  SectionsStatsNotifier sectionsStatsNotifier = SectionsStatsNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final sections = ref.watch(sectionsProvider);
    sections.whenData((value) {
      sectionsStatsNotifier.loadTList(value);
    });
  });
  return sectionsStatsNotifier;
});
