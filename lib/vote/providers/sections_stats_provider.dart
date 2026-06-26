import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';

class SectionsStatsNotifier extends MapNotifier<SectionComplete, int> {
  @override
  Map<SectionComplete, AsyncValue<List<int>>?> build() {
    final sections = ref.watch(sectionsProvider);
    sections.whenData((value) {
      loadTList(value);
    });
    return state;
  }
}

final sectionsStatsProvider =
    NotifierProvider<
      SectionsStatsNotifier,
      Map<SectionComplete, AsyncValue<List<int>>?>
    >(SectionsStatsNotifier.new);
