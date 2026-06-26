import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupIdNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setId(String id) {
    state = id;
  }
}

final groupIdProvider = NotifierProvider<GroupIdNotifier, String>(
  () => GroupIdNotifier(),
);
