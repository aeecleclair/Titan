import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/members.dart';

class PretendanceMembersProvider extends StateNotifier<List<Member>> {
  PretendanceMembersProvider() : super([]);

  void addMember(Member m) {
    var copy = state.toList();
    copy.add(m);
    state = copy;
  }

  void removeMember(Member m) {
    var copy = state.toList();
    copy.remove(m);
    state = copy;
  }

  void clearMembers() {
    state = [];
  }
}

final pretendanceMembersProvider =
    StateNotifierProvider<PretendanceMembersProvider, List<Member>>((ref) {
  return PretendanceMembersProvider();
});
