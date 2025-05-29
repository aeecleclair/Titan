import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/top_bar_callback.dart';

class AnimationNotifier extends StateNotifier<TopBarCallback> {
  AnimationNotifier() : super(TopBarCallback(moduleRoot: ''));

  void setCallBacks(TopBarCallback callbacks) {
    if (state.moduleRoot == callbacks.moduleRoot) {
      return;
    }
    state = callbacks;
  }
}

final topBarCallBackProvider =
    StateNotifierProvider<AnimationNotifier, TopBarCallback>((ref) {
      return AnimationNotifier();
    });
