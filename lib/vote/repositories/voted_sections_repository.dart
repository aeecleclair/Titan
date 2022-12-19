import 'package:myecl/tools/repository/repository.dart';

class VotedSectionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/votes';

  Future<List<String>> getVotes() async {
    return (await getList()).cast();
  }
}
