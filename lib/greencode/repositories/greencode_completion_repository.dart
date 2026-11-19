import 'package:myecl/greencode/class/completion.dart';
import 'package:myecl/tools/repository/repository.dart';

class GreenCodeCompletionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'greencode/completion/';

  Future<List<Completion>> getAllGreenCodeCompletions() async {
    return (await getList(suffix: 'all'))
        .map((jsonCompletion) => Completion.fromJson(jsonCompletion))
        .toList();
  }

  Future<Completion> getCurrentUserGreenCodeCompletion() async {
    return Completion.fromJson(await getOne("me"));
  }

  Future<Completion> getGreenCodeCompletionByUser(String userId) async {
    return Completion.fromJson(await getOne(userId));
  }
}
