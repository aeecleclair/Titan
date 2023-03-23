import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/class/bird.dart';
import 'package:myecl/flap/providers/bird_image_provider.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';

class BirdNotifier extends StateNotifier<Bird> {
  BirdNotifier() : super(Bird.empty());

  void setBird(Bird bird) {
    state = bird;
  }

  void setBirdImage(Widget birdImage) {
    state = state.copyWith(birdImage: birdImage);
  }

  void setUser(SimpleUser user) {
    state = state.copyWith(user: user);
  }

  Bird update() {
    return state = state.copyWith(
      time: state.time + 0.01,
      birdPosition: state.initialPosition -
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
    state = state.copyWith(
      score: state.score + 1,
    );
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

final birdProvider = StateNotifierProvider<BirdNotifier, Bird>((ref) {
  BirdNotifier notifier = BirdNotifier();
  final user = ref.watch(userProvider);
  final birdImage = ref.watch(birdImageProvider);
  final birdImageNotifier = ref.watch(birdImageProvider.notifier);
  notifier.setUser(user.toSimpleUser());
  if (birdImage.isNotEmpty) {
    // ignore: invalid_use_of_protected_member
    birdImageNotifier.switchColor(notifier.state.color).then((value) {
      notifier.setBirdImage(Image.memory(value));
      return notifier;
    });
  }
  return notifier;
});
