import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/votes.dart';

class VotesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/votes';

  Future<List<Votes>> getVotes() async {
    return (await getList()).map((x) => Votes.fromJson(x)).toList();
  }

  Future<Votes> addVote(Votes votes) async {
    return await create(votes);
  }

  Future<bool> removeVote() async {
    return await delete("");
  }

  Future<List<Votes>> getVote(String id) async {
    return (await getOne(id)).map((x) => Votes.fromJson(x)).toList();
  }
}