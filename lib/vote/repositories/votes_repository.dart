import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/auth/providers/openid_provider.dart';
import 'package:myemapp/tools/repository/repository.dart';
import 'package:myemapp/vote/class/votes.dart';

class VotesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/votes';

  Future<Votes> addVote(Votes votes) async {
    await create(votes.toJson());
    return votes;
  }

  Future<bool> removeVote() async {
    return await delete("");
  }
}

final votesRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return VotesRepository()..setToken(token);
});
