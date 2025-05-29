import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/class/simple_users.dart';

class StructureManagerProvider extends StateNotifier<SimpleUser> {
  StructureManagerProvider() : super(SimpleUser.empty());

  void setUser(SimpleUser id) {
    state = id;
  }
}

final structureManagerProvider =
    StateNotifierProvider<StructureManagerProvider, SimpleUser>(
      (ref) => StructureManagerProvider(),
    );
