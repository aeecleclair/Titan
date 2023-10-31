import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/class/list_users.dart';

class SharerGroupMemberListProvider extends StateNotifier<List<SimpleUser>> {
  SharerGroupMemberListProvider() : super([]);

  void addMember(SimpleUser i) {
    state = [...state, i];
  }

  void removeMember(SimpleUser i) {
    state = state.where((element) => element.id != i.id).toList();
  }

  void reset() {
    state = [];
  }
}

final sharerGroupMemberListProvider =
    StateNotifierProvider<SharerGroupMemberListProvider, List<SimpleUser>>(
        (ref) {
  return SharerGroupMemberListProvider();
});
