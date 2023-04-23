import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';

class RolesTagsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/";

  Future<RolesTags> getRolesTags() async {
    return fakeRolesTags;
    // return RolesTags.fromJSON(await getOne("rolesTags"));
  }
}


