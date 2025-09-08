import 'package:titan/phonebook/class/roles_tags.dart';
import 'package:titan/tools/repository/repository.dart';

class RolesTagsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/";

  Future<RolesTags> getRolesTags() async {
    RolesTags rolesTags = RolesTags.fromJson(await getOne("roletags"));
    return rolesTags;
  }
}
