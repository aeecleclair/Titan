import 'package:flutter_riverpod/flutter_riverpod.dart';

final authTokenProvider = StateNotifierProvider<AuthTokenProvider, String>((ref) {
  return AuthTokenProvider();
});

class AuthTokenProvider extends StateNotifier<String> {
  AuthTokenProvider() : super("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwODg2NGUzNi05ZjRjLTQ2M2UtYjBkNy03ODg1MmIxYmMwODgiLCJleHAiOjE2NTI2MjgzMDZ9.AFfZibSA6wFKo-9yDAIj6Ts4aPdUSsqr8NKdqWltt8E");
}
