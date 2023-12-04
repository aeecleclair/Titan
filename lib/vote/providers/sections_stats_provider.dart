import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionsStatsNotifier extends MapNotifier<SectionComplete, int> {
  SectionsStatsNotifier();
}

final sectionsStatsProvider = StateNotifierProvider<SectionsStatsNotifier,
    AsyncValue<Map<SectionComplete, AsyncValue<List<int>>>>>((ref) {
  SectionsStatsNotifier sectionsStatsNotifier = SectionsStatsNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final sections = ref.watch(sectionsProvider);
    sections.whenData((value) {
      sectionsStatsNotifier.loadTList(value);
    });
  });
  return sectionsStatsNotifier;
});
