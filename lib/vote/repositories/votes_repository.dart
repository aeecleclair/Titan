import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/votes.dart';

class VotesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/votes';

  VotesRepository(super.ref);

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
  return VotesRepository(ref)..setToken(token);
});
