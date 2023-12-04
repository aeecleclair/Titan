import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class ContenderMembersProvider extends StateNotifier<List<ListMemberComplete>> {
  ContenderMembersProvider() : super([]);

  Future<bool> addMember(ListMemberComplete m) async {
    var copy = state.toList();
    if (!copy.contains(m)) {
      copy.add(m);
      state = copy;
      return true;
    }
    return false;
  }

  void removeMember(ListMemberComplete m) {
    var copy = state.toList();
    copy.remove(m);
    state = copy;
  }

  void clearMembers() {
    state = [];
  }

  void setMembers(List<ListMemberComplete> members) {
    state = members;
  }
}

final contenderMembersProvider =
    StateNotifierProvider<ContenderMembersProvider, List<ListMemberComplete>>(
        (ref) {
  return ContenderMembersProvider();
});
