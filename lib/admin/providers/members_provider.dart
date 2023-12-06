import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class MembersNotifier extends StateNotifier<List<CoreUserSimple>> {
  MembersNotifier() : super(const []);

  void add(CoreUserSimple user) {
    state = state.sublist(0)..add(user);
  }

  void remove(CoreUserSimple user) {
    state = state.where((element) => element.id != user.id).toList();
  }
}

final membersProvider =
    StateNotifierProvider<MembersNotifier, List<CoreUserSimple>>(
  (ref) => MembersNotifier(),
);
