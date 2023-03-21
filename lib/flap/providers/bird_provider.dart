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

  void jump() {
    state.jump();
  }
}

final birdProvider = StateNotifierProvider<BirdNotifier, Bird>((ref) {
  BirdNotifier notifier = BirdNotifier();
  final user = ref.watch(userProvider);
  final birdImage = ref.watch(birdImageProvider);
  final birdImageNotifier = ref.watch(birdImageProvider.notifier);
  notifier.setUser(user.toSimpleUser());
  if (birdImage.isNotEmpty) {
    birdImageNotifier.switchColor(notifier.state.color).then((value) {
      print("Bird Image Switched");
      notifier.setBirdImage(Image.memory(value));
      print("Bird Image Set");
      return notifier;
    });
  }
  return notifier;
});
