import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
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

final rolesTagsRepositoryProvider = Provider<RolesTagsRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return RolesTagsRepository(ref)..setToken(token);
});
