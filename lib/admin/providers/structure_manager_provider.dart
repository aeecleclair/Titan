import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/class/simple_users.dart';

class StructureManagerProvider extends StateNotifier<SimpleUser> {
  StructureManagerProvider() : super(SimpleUser.empty());

  void setUser(SimpleUser user) {
    state = user;
  }
}

final structureManagerProvider =
    StateNotifierProvider<StructureManagerProvider, SimpleUser>(
      (ref) => StructureManagerProvider(),
    );
