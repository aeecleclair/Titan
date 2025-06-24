import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';

class SectionContender extends MapNotifier<Section, Contender> {
  SectionContender() : super();
}

final sectionContenderProvider =
    StateNotifierProvider<
      SectionContender,
      Map<Section, AsyncValue<List<Contender>>?>
    >((ref) {
      SectionContender adminLoanListNotifier = SectionContender();
      tokenExpireWrapperAuth(ref, () async {
        final loaners = ref.watch(sectionList);
        final contenders = ref.watch(contenderListProvider);
        List<Contender> list = [];
        contenders.when(
          data: (contender) {
            list = contender;
          },
          error: (error, stackTrace) {
            list = [];
          },
          loading: () {
            list = [];
          },
        );
        adminLoanListNotifier.loadTList(loaners);
        for (final l in loaners) {
          adminLoanListNotifier.setTData(
            l,
            AsyncValue.data(
              list.where((element) => element.section.id == l.id).toList(),
            ),
          );
        }
      });
      return adminLoanListNotifier;
    });
