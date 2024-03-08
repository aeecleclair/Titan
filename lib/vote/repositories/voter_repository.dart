import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/voter.dart';

class VoterRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "campaign/voters";

  Future<bool> deleteVoter(String voterId) async {
    return await delete("/$voterId");
  }

  Future<Voter> createVoter(Voter voter) async {
    return Voter.fromJson(await create(voter.toJson()));
  }

  Future<List<Voter>> getVoters() async {
    return (await getList())
        .map((e) => Voter.fromJson(e))
        .toList();
  }
}
