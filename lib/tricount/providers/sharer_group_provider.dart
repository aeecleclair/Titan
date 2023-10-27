import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group.dart';

class SharerGroupProvider extends StateNotifier<SharerGroup> {
  SharerGroupProvider() : super(SharerGroup.empty());

  void setSharerGroup(SharerGroup i) {
    state = i;
  }
}

final sharerGroupProvider =
    StateNotifierProvider<SharerGroupProvider, SharerGroup>((ref) {
  return SharerGroupProvider();
});
