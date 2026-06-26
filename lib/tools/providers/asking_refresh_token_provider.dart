import 'package:flutter_riverpod/flutter_riverpod.dart';

class AskingRefreshTokenNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setAskingRefresh(bool bool) {
    state = bool;
  }
}

final askingRefreshTokenProvider =
    NotifierProvider<AskingRefreshTokenNotifier, bool>(
      AskingRefreshTokenNotifier.new,
    );
