import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class SessionNotifier extends StateNotifier<CineSessionComplete> {
  SessionNotifier() : super(EmptyModels.empty<CineSessionComplete>());

  void setSession(CineSessionComplete event) {
    state = event;
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, CineSessionComplete>((ref) {
  return SessionNotifier();
});
