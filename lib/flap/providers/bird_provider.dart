import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/class/bird.dart';

class BirdNotifier extends StateNotifier<Bird> {
  BirdNotifier() : super(Bird.empty());

  void setBird(Bird bird) {
    state = bird;
  }
}

final birdProvider = StateNotifierProvider<BirdNotifier, Bird>((ref) {
  return BirdNotifier();
});
