import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwipeControllerNotifier extends StateNotifier<AnimationController> {
  SwipeControllerNotifier(super.controller);

  static const double maxSlide = 255;
  static const dragRightStartVal = 60;
  static const dragLeftStartVal = maxSlide - 30;
  static bool shouldDrag = false;

  void close() {
    state.reverse();
  }

  void open() {
    state.forward();
  }

  void toggle() {
    if (state.isCompleted) {
      close();
    } else {
      open();
    }
  }

  void onDragStart(DragStartDetails startDetails) {
    bool isDraggingFromLeft =
        state.isDismissed && startDetails.globalPosition.dx < dragRightStartVal;
    bool isDraggingFromRight =
        !state.isDismissed && startDetails.globalPosition.dx > dragLeftStartVal;
    shouldDrag = isDraggingFromLeft || isDraggingFromRight;
  }

  void onDragUpdate(DragUpdateDetails updateDetails) {
    if (shouldDrag) {
      double delta = updateDetails.primaryDelta! / maxSlide;
      state.value += delta;
    }
  }

  void onDragEnd(DragEndDetails endDetails, double width) {
    if (!state.isDismissed && !state.isCompleted) {
      double minFlingVelocity = 365.0;
      double dragVelocity = endDetails.velocity.pixelsPerSecond.dx.abs();
      if (dragVelocity >= minFlingVelocity) {
        double visualVelocity = endDetails.velocity.pixelsPerSecond.dx / width;
        state.fling(velocity: visualVelocity);
      } else if (state.value < 0.5) {
        close();
      } else {
        open();
      }
    }
  }
}

final swipeControllerProvider =
    StateNotifierProvider.family<
      SwipeControllerNotifier,
      AnimationController,
      AnimationController
    >((ref, animationController) {
      return SwipeControllerNotifier(animationController);
    });
