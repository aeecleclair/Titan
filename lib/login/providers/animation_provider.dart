import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimationNotifier extends Notifier<AnimationController?> {
  @override
  AnimationController? build() {
    return null;
  }

  void setController(AnimationController controller) {
    state = controller;
  }

  void toggle() {
    if (state == null) {
      return;
    }
    if (state!.isCompleted) {
      state!.reverse();
    } else {
      state!.forward();
    }
  }

  double get value {
    if (state == null) {
      return 0;
    }
    return state!.value;
  }

  AnimationController? get animation {
    return state;
  }
}

final backgroundAnimationProvider =
    NotifierProvider<AnimationNotifier, AnimationController?>(
      AnimationNotifier.new,
    );
