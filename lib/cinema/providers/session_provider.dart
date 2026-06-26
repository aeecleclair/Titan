import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SessionNotifier extends Notifier<CineSessionComplete> {
  @override
  CineSessionComplete build() {
    return CineSessionComplete.empty();
  }

  void setSession(CineSessionComplete event) {
    state = event;
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, CineSessionComplete>(
  SessionNotifier.new,
);
