import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:tuple/tuple.dart';


final memberRolesTagsProvider = StateNotifierProvider<MemberRolesTagsProvider, List<String>>((ref) {
  return MemberRolesTagsProvider();
});

class MemberRolesTagsProvider extends StateNotifier<List<String>> {
  MemberRolesTagsProvider() : super([]);

  void setRoleTagsWithFilter(Tuple2<RolesTags,List<bool>> data) {
    debugPrint(data.item1.tags.toString());
    debugPrint(data.item2.toString());
    List<String> newRoleTags = [];
    for (int i = 0; i < data.item2.length; i++) {
      if (data.item2[i]) {
        newRoleTags.add(data.item1.tags[i]);
      }
    }
    state = newRoleTags;
    debugPrint(state.toString());
  }
}