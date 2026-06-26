import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/vote/providers/list_list_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';

class SectionList extends MapNotifier<SectionComplete, ListReturn> {
  @override
  Map<SectionComplete, AsyncValue<List<ListReturn>>?> build() {
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
    loadTList(loaners);
    for (final l in loaners) {
      setTData(
        l,
        AsyncValue.data(
          list.where((element) => element.section.id == l.id).toList(),
        ),
      );
    }
    return {};
  }
}

final sectionListProvider =
    NotifierProvider<
      SectionList,
      Map<SectionComplete, AsyncValue<List<ListReturn>>?>
    >(SectionList.new);
