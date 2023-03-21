import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/class/bird.dart';
import 'package:myecl/flap/providers/bird_image_provider.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';

class PipeListNotifier extends StateNotifier<List<List<double>>> {
  late final double height;
  List<double> xPipeAlignment = [
    1.0,
    2.2,
    3.4,
  ];
  PipeListNotifier() : super([]);

  void setHeight(double height) {
    this.height = height;
  }

  List<double> generateRandomPipeHeights() {
    final random = Random();
    final randomHeight = random.nextInt(300).toDouble() + 50;
    return [randomHeight, height - randomHeight - 200];
  }
}

final pipeListProvider =
    StateNotifierProvider<PipeListNotifier, List<List<double>>>((ref) {
  return PipeListNotifier();
});
