import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class UserCreationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<bool> createUsers(List<String> mailList) async {
    final json = mailList.map((email) => {'email': email}).toList();
    return await create(json, suffix: "batch-invitation");
  }
}

final userCreationRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return UserCreationRepository()..setToken(token);
});
