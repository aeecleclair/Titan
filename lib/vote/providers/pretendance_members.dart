import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/members.dart';

class PretendanceMembersProvider extends StateNotifier<List<Member>> {
  PretendanceMembersProvider() : super([]);

  Future<bool> addMember(Member m) async {
    var copy = state.toList();
    print(copy);
    print(copy.contains(m));
    if (!copy.contains(m)) {
      copy.add(m);
      state = copy;
      return true;
    }
    return false;
  }

  void removeMember(Member m) {
    var copy = state.toList();
    copy.remove(m);
    state = copy;
  }

  void clearMembers() {
    state = [];
  }

  void setMembers(List<Member> members) {
    state = members;
  }
}

final pretendanceMembersProvider =
    StateNotifierProvider<PretendanceMembersProvider, List<Member>>((ref) {
  return PretendanceMembersProvider();
});
