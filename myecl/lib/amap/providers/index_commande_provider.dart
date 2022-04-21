import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexCmdProvider = StateNotifierProvider<IndexCmd, int>((ref) {
  return IndexCmd();
});

class IndexCmd extends StateNotifier<int> {
  IndexCmd() : super(-1);

  void setIndex(int i) {
    state = i;
  }
}
