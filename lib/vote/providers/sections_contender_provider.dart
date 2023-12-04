import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/providers/contender_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionContender extends MapNotifier<SectionComplete, ListReturn> {
  SectionContender() : super();
}

final sectionContenderProvider = StateNotifierProvider<SectionContender,
    AsyncValue<Map<SectionComplete, AsyncValue<List<ListReturn>>>>>((ref) {
  SectionContender adminLoanListNotifier = SectionContender();
  tokenExpireWrapperAuth(ref, () async {
    final loaners = ref.watch(sectionList);
    final contenders = ref.watch(contenderListProvider);
    List<ListReturn> list = [];
    contenders.maybeWhen(data: (contender) {
      list = contender;
    }, orElse: () {
      list = [];
    });
    adminLoanListNotifier.loadTList(loaners);
    for (final l in loaners) {
      adminLoanListNotifier.setTData(
          l,
          AsyncValue.data(
              list.where((element) => element.section.id == l.id).toList()));
    }
  });
  return adminLoanListNotifier;
});
