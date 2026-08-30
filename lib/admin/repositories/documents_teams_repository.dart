import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/document_team.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class DocumentTeamsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "documents/teams/";

  Future<List<DocumentTeam>> getMeDocumentTeamsList() async {
    return List<DocumentTeam>.from(
      (await getList(suffix: "me")).map((x) => DocumentTeam.fromJson(x)),
    );
  }
}

final documentTeamsRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return DocumentTeamsRepository()..setToken(token);
});
