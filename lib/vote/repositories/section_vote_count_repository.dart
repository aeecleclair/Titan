import 'package:myecl/tools/repository/repository.dart';

class SectionVoteCountRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/stats/';

  SectionVoteCountRepository(super.ref);

  Future<int> getSectionVoteCount(String id) async {
    return await getOne(id);
  }
}
