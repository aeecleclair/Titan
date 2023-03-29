import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/class/votes.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionsVotesProvider extends MapNotifier<Section, Votes> {
  SectionsVotesProvider() : super();
}

final sectionsVotesProvider = StateNotifierProvider<SectionsVotesProvider,
    AsyncValue<Map<Section, AsyncValue<List<Votes>>>>>((ref) {
  SectionsVotesProvider adminloanListNotifier =
      SectionsVotesProvider();
  tokenExpireWrapperAuth(ref, () async {
    final sections = ref.watch(sectionsProvider);
    List<Section> list = [];
    sections.when(data: (votes) {
      list = votes;
    }, error: (error, stackTrace) {
      list = [];
    }, loading: () {
      list = [];
    });
    adminloanListNotifier.loadTList(list);
  });
  return adminloanListNotifier;
});
