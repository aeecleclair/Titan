import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwipeControllerNotifier extends StateNotifier<AnimationController> {
  SwipeControllerNotifier(AnimationController _controller) : super(_controller);

  static const double maxSlide = 255;
  static const dragRigthStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
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
    bool isDarggingFromLeft =
        state.isDismissed && startDetails.globalPosition.dx < dragRigthStartVal;
    bool isDarggingFromRight =
        !state.isDismissed && startDetails.globalPosition.dx > dragLeftStartVal;
    shouldDrag = isDarggingFromLeft || isDarggingFromRight;
  }

  void onDragUpdate(DragUpdateDetails updateDetails) {
    if (shouldDrag) {
      double delta = updateDetails.primaryDelta! / maxSlide;
      state.value += delta;
    }
  }

  void onDragEnd(DragEndDetails endDetails, double width) {
    if (!state.isDismissed && !state.isCompleted) {
      double _minFlingVelocity = 365.0;
      double dragVelocity = endDetails.velocity.pixelsPerSecond.dx.abs();
      if (dragVelocity >= _minFlingVelocity) {
        double visualVelovity = endDetails.velocity.pixelsPerSecond.dx / width;
        state.fling(velocity: visualVelovity);
      } else if (state.value < 0.5) {
        close();
      } else {
        open();
      }
    }
  }
}

final swipeControllerProvider = StateNotifierProvider.family<
    SwipeControllerNotifier,
    AnimationController,
    AnimationController>((ref, animationController) {
  return SwipeControllerNotifier(animationController);
});
