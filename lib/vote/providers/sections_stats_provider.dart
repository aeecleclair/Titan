import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myemapp/tools/providers/map_provider.dart';
import 'package:myemapp/tools/token_expire_wrapper.dart';
import 'package:myemapp/vote/class/section.dart';
import 'package:myemapp/vote/providers/sections_provider.dart';

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
