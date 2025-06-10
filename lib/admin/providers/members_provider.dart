import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/user/class/simple_users.dart';

class MembersNotifier extends StateNotifier<List<SimpleUser>> {
  MembersNotifier() : super(const []);

  void add(SimpleUser user) {
    state = state.sublist(0)..add(user);
  }

  void remove(SimpleUser user) {
    state = state.where((element) => element.id != user.id).toList();
  }
}

final membersProvider =
    StateNotifierProvider<MembersNotifier, List<SimpleUser>>(
      (ref) => MembersNotifier(),
    );
