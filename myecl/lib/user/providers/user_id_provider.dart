import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserIdNotifier extends StateNotifier<String> {
  UserIdNotifier() : super("a4237b44-e0a6-4e0c-9cfd-7a418752dafc");

  void setPage(String id) {
    state = id;
  }
}

final userIdProvider = StateNotifierProvider<UserIdNotifier, String>((ref) {
  return UserIdNotifier();
});
