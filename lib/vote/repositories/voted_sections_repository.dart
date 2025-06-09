import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/auth/providers/openid_provider.dart';
import 'package:myemapp/tools/repository/repository.dart';

class VotedSectionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/votes';

  Future<List<String>> getVotes() async {
    return (await getList()).cast();
  }
}

final votedSectionRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return VotedSectionRepository()..setToken(token);
});
