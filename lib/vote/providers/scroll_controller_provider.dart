import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  ScrollControllerNotifier(super.scrollController);
}

final scrollControllerProvider =
    StateNotifierProvider.family<
      ScrollControllerNotifier,
      ScrollController,
      AnimationController
    >((ref, animationController) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        switch (scrollController.position.userScrollDirection) {
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
      return ScrollControllerNotifier(scrollController);
    });
