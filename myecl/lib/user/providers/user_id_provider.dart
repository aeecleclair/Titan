import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserIdNotifier extends StateNotifier<String> {
  UserIdNotifier() : super("08864e36-9f4c-463e-b0d7-78852b1bc088");

  void setId(String id) {
    state = id;
  }
}

final userIdProvider = StateNotifierProvider<UserIdNotifier, String>((ref) {
  return UserIdNotifier();
});
