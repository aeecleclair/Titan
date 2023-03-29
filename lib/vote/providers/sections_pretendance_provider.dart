import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionPretendance extends MapNotifier<Section, Pretendance> {
  SectionPretendance() : super();
}

final sectionPretendanceProvider = StateNotifierProvider<SectionPretendance,
    AsyncValue<Map<Section, AsyncValue<List<Pretendance>>>>>((ref) {
  SectionPretendance adminloanListNotifier = SectionPretendance();
  tokenExpireWrapperAuth(ref, () async {
    final loaners = ref.watch(sectionList);
    final pretendances = ref.watch(pretendanceListProvider);
    List<Pretendance> list = [];
    pretendances.when(data: (pretendance) {
      list = pretendance;
    }, error: (error, stackTrace) {
      list = [];
    }, loading: () {
      list = [];
    });
    adminloanListNotifier.loadTList(loaners);
    for (final l in loaners) {
      adminloanListNotifier.setTData(
          l,
          AsyncValue.data(
              list.where((element) => element.section.id == l.id).toList()));
    }
  });
  return adminloanListNotifier;
});
