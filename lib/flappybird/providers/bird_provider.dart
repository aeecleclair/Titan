import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/flappybird/class/bird.dart';
import 'package:titan/flappybird/providers/bird_image_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/user/adapters/core_user.dart';
import 'package:titan/user/providers/user_provider.dart';

class BirdNotifier extends Notifier<Bird> {
  @override
  Bird build() {
    final user = ref.watch(userProvider);
    final birdImage = ref.watch(birdImageProvider);
    final birdImageNotifier = ref.watch(birdImageProvider.notifier);

    setUser(user.toCoreUserSimple());
    if (birdImage.isNotEmpty) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      birdImageNotifier.switchColor(state.color).then((value) {
        setBirdImage(Image.memory(value));
      });
    }

    return Bird.empty();
  }

  void setBird(Bird bird) {
    state = bird;
  }

  void setBirdImage(Widget birdImage) {
    state = state.copyWith(birdImage: birdImage);
  }

  void setUser(CoreUserSimple user) {
    state = state.copyWith(user: user);
  }

  Bird update() {
    return state = state.copyWith(
      time: state.time + 0.01,
      birdPosition:
          state.initialPosition -
          state.gravity * state.time * state.time -
          state.velocity * state.time,
      angle: state.angle + 0.01,
    );
  }

  void jump() {
    state = state.copyWith(
      initialPosition: state.birdPosition,
      time: 0,
      angle: -pi / 4,
    );
  }

  void increaseScore() {
    state = state.copyWith(score: state.score + 1);
  }

  void resetBird() {
    state = state.copyWith(
      birdPosition: 0,
      initialPosition: 0,
      time: 0,
      angle: 0,
      score: 0,
    );
  }
}

final birdProvider = NotifierProvider<BirdNotifier, Bird>(BirdNotifier.new);
