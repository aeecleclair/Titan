import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class ListMembersProvider extends Notifier<List<ListMemberComplete>> {
  @override
  List<ListMemberComplete> build() {
    return [];
  }

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

final listMembersProvider =
    NotifierProvider<ListMembersProvider, List<ListMemberComplete>>(
      ListMembersProvider.new,
    );
