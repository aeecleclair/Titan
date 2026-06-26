import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';

class MembersNotifier extends Notifier<List<CoreUserSimple>> {
  @override
  List<CoreUserSimple> build() {
    return const [];
  }

  void add(CoreUserSimple user) {
    state = state.sublist(0)..add(user);
  }

  void remove(CoreUserSimple user) {
    state = state.where((element) => element.id != user.id).toList();
  }
}

final membersProvider = NotifierProvider<MembersNotifier, List<CoreUserSimple>>(
  () => MembersNotifier(),
);
