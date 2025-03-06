import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/vote/providers/list_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionList extends MapNotifier<SectionComplete, ListReturn> {
  SectionList() : super();
}

final sectionListProvider = StateNotifierProvider<SectionList,
    Map<SectionComplete, AsyncValue<List<ListReturn>>?>>((ref) {
  SectionList sectionListNotifier = SectionList();
  final loaners = ref.watch(sectionList);
  final lists = ref.watch(listListProvider);
  List<ListReturn> list = [];
  lists.when(
    data: (list) {
      list = list;
    },
    error: (error, stackTrace) {
      list = [];
    },
    loading: () {
      list = [];
    },
  );
  sectionListNotifier.loadTList(loaners);
  for (final l in loaners) {
    sectionListNotifier.setTData(
      l,
      AsyncValue.data(
        list.where((element) => element.section.id == l.id).toList(),
      ),
    );
  }
  return sectionListNotifier;
});
