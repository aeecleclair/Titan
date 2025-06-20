import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/tools/repository/repository.dart';

class RolesTagsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/";

  RolesTagsRepository(super.ref);

  Future<RolesTags> getRolesTags() async {
    RolesTags rolesTags = RolesTags.fromJson(await getOne("roletags"));
    return rolesTags;
  }
}
