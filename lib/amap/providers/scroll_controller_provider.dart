import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  ScrollControllerNotifier(ScrollController scrollController)
      : super(scrollController);
}

final scrollControllerProvider = StateNotifierProvider.family<
    ScrollControllerNotifier,
    ScrollController,
    AnimationController>((ref, animationController) {
  ScrollController _scrollController = ScrollController();

  _scrollController.addListener(() {
    switch (_scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        animationController.forward();
        break;

      case ScrollDirection.reverse:
        animationController.reverse();

        break;

      case ScrollDirection.idle:
        break;
    }
  });
  return ScrollControllerNotifier(_scrollController);
});
