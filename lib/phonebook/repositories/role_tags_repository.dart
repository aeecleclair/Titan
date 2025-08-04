import 'package:titan/tools/repository/repository.dart';

class RolesTagsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/";

  Future<List<String>> getRolesTags() async {
    return List<String>.from((await getOne("roletags"))["tags"]);
  }
}
