import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScrollControllerNotifier extends Notifier<ScrollController> {
  ScrollControllerNotifier(this.animationController);
  final AnimationController animationController;

  @override
  ScrollController build() {
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
    return scrollController;
  }
}

final scrollControllerProvider =
    NotifierProvider.family<
      ScrollControllerNotifier,
      ScrollController,
      AnimationController
    >(ScrollControllerNotifier.new);
