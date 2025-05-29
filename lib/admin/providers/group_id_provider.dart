import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupIdNotifier extends StateNotifier<String> {
  GroupIdNotifier() : super("");

  void setId(String id) {
    state = id;
  }
}

final groupIdProvider = StateNotifierProvider<GroupIdNotifier, String>(
  (ref) => GroupIdNotifier(),
);
