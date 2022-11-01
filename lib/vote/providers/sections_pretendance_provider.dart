import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SectionPretendance extends MapNotifier<Section, Pretendance> {
  SectionPretendance({required String token}) : super(token: token);
}

final sectionPretendanceProvider = StateNotifierProvider<SectionPretendance,
    AsyncValue<Map<Section, AsyncValue<List<Pretendance>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loaners = ref.watch(sectionList);
  SectionPretendance adminloanListNotifier = SectionPretendance(token: token);
  adminloanListNotifier.loadTList(loaners);
  return adminloanListNotifier;
});
