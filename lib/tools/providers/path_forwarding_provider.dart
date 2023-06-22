import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/class/path_forwarding.dart';

class PathForwardingProvider extends StateNotifier<PathForwarding> {
  PathForwardingProvider() : super(PathForwarding.empty());

  void forward(String path) {
    state = state.copyWith(path: path, isForwarding: true, canForward: false);
  }

  void check() {
    state = state.copyWith(canForward: true);
  }

  void reset() {
    state = PathForwarding.empty();
  }
}

final pathForwardingProvider =
    StateNotifierProvider<PathForwardingProvider, PathForwarding>(
        (ref) => PathForwardingProvider());
