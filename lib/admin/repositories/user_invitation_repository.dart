import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class UserInvitationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<List<String>> createUsers(
    List<String> mailList,
    String? groupId,
  ) async {
    final json = mailList
        .map((email) => {'email': email, "default_group_id": groupId})
        .toList();
    final result = (await create(json, suffix: "batch-invitation"))["failed"];
    List<String> failedEmails = [];
    for (var entry in result.entries) {
      if (entry.value != "User already invited") failedEmails.add(entry.key);
    }
    return failedEmails;
  }
}

final userInvitationRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return UserInvitationRepository()..setToken(token);
});
