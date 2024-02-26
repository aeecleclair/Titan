import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:tuple/tuple.dart';

final memberRoleTagsProvider =
    StateNotifierProvider<MemberRoleTagsProvider, List<String>>((ref) {
  return MemberRoleTagsProvider();
});

class MemberRoleTagsProvider extends StateNotifier<List<String>> {
  MemberRoleTagsProvider() : super([]);

  void setRoleTagsWithFilter(Tuple2<RolesTags, List<bool>> data) {
    List<String> newRoleTags = [];
    for (int i = 0; i < data.item2.length; i++) {
      if (data.item2[i]) {
        newRoleTags.add(data.item1.tags[i]);
      }
    }
    state = newRoleTags;
  }
}
