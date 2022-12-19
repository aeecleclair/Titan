import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/votes.dart';

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
