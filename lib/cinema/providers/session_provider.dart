import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class SessionNotifier extends StateNotifier<CineSessionComplete> {
  SessionNotifier() : super(CineSessionComplete.fromJson({}));

  void setSession(CineSessionComplete event) {
    state = event;
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, CineSessionComplete>((ref) {
  return SessionNotifier();
});
