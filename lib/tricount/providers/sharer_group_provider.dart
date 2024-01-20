import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group.dart';

class SharerGroupMemberListProvider extends StateNotifier<SharerGroup> {
  SharerGroupMemberListProvider() : super(SharerGroup.empty());

  void set(SharerGroup i) {
    state = i;
  }
}

final sharerGroupProvider =
    StateNotifierProvider<SharerGroupMemberListProvider, SharerGroup>(
        (ref) {
  return SharerGroupMemberListProvider();
});
