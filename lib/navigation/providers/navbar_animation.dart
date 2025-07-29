import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavbarAnimationProvider extends StateNotifier<AnimationController?> {
  NavbarAnimationProvider() : super(null);

  int _modalCount = 0;

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

  void show() {
    if (state == null) {
      return;
    }
    if (state!.isDismissed) {
      state!.forward();
    }
  }

  void hide() {
    if (state == null) {
      return;
    }
    if (state!.isCompleted) {
      state!.reverse();
    }
  }

  void hideForModal() {
    _modalCount++;
    if (_modalCount == 1) {
      hide();
    }
  }

  void showForModal() {
    _modalCount--;
    if (_modalCount == 0) {
      show();
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

  int get modalCount => _modalCount;
}

final navbarAnimationProvider =
    StateNotifierProvider<NavbarAnimationProvider, AnimationController?>((ref) {
      return NavbarAnimationProvider();
    });
