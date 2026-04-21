import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/class/path_forwarding.dart';

class PathForwardingProvider extends StateNotifier<PathForwarding> {
  PathForwardingProvider() : super(PathForwarding.empty());

  void forward(String path, {Map<String, String>? queryParameters}) {
    state = state.copyWith(path: path, queryParameters: queryParameters);
  }

  void removeQueryParam(String key) {
    final currentParams = state.queryParameters;
    if (currentParams == null) return;
    final newParams = Map<String, String>.from(currentParams)..remove(key);
    state = state.copyWith(
      queryParameters: newParams.isEmpty ? null : newParams,
    );
  }

  void clearParams() {
    state = state.copyWith(queryParameters: null);
  }

  void login() {
    state = state.copyWith(isLoggedIn: true);
  }

  void reset() {
    state = PathForwarding.empty();
  }
}

final pathForwardingProvider =
    StateNotifierProvider<PathForwardingProvider, PathForwarding>(
      (ref) => PathForwardingProvider(),
    );
