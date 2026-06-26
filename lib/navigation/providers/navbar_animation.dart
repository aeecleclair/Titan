import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavbarAnimationProvider extends Notifier<AnimationController?> {
  @override
  AnimationController? build() {
    return null;
  }

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
    NotifierProvider<NavbarAnimationProvider, AnimationController?>(
      NavbarAnimationProvider.new,
    );
