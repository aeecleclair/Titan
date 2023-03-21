import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/class/pipe.dart';

class PipeListNotifier extends StateNotifier<List<Pipe>> {
  PipeListNotifier() : super([
    Pipe.random(position: 1),
    Pipe.random(position: 2.2),
    Pipe.random(position: 3.4),
  ]);
}

final pipeListProvider =
    StateNotifierProvider<PipeListNotifier, List<Pipe>>((ref) {
  return PipeListNotifier();
});
