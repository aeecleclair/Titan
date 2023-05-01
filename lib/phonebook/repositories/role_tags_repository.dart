import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:tuple/tuple.dart';

class RolesTagsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/";

  Future<Tuple2<RolesTags,List<bool>>> getRolesTags() async {
    // return Tuple2(fakeRolesTags,List<bool>.filled(fakeRolesTags.tags.length, false));
    RolesTags rolesTags = RolesTags.fromJSON(await getOne("rolesTags"));
    return Tuple2(rolesTags,List<bool>.filled(rolesTags.tags.length, false));
  }
}


