import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/providers/sections_provider.dart';

class SectionsStatsNotifier extends MapNotifier<Section, int> {
  SectionsStatsNotifier();
}

final sectionsStatsProvider =
    StateNotifierProvider<
      SectionsStatsNotifier,
      Map<Section, AsyncValue<List<int>>?>
    >((ref) {
      SectionsStatsNotifier sectionsStatsNotifier = SectionsStatsNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final sections = ref.watch(sectionsProvider);
        sections.whenData((value) {
          sectionsStatsNotifier.loadTList(value);
        });
      });
      return sectionsStatsNotifier;
    });
