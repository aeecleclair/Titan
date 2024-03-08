import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class SectionVoteCountRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/stats/';

  Future<int> getSectionVoteCount(String id) async {
    return await getValue(id) as int;
  }
}

final sectionVoteCountRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return SectionVoteCountRepository()..setToken(token);
});
