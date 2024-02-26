import 'package:flutter/material.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:tuple/tuple.dart';

class RolesTagsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/";

  Future<RolesTags> getRolesTags() async {
    RolesTags rolesTags = RolesTags.fromJson(await getOne("roletags"));
    debugPrint(rolesTags.toString());
    return rolesTags;
  }
}
