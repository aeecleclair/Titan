import 'package:flutter_riverpod/flutter_riverpod.dart';

class AskingRefreshTokenNotifier extends StateNotifier<bool> {
  AskingRefreshTokenNotifier() : super(false);

  void setAskingRefresh(bool bool) {
    state = bool;
  }
}

final askingRefreshTokenProvider =
    StateNotifierProvider<AskingRefreshTokenNotifier, bool>((ref) {
      return AskingRefreshTokenNotifier();
    });
