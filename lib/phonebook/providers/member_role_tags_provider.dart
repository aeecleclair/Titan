import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:tuple/tuple.dart';

final memberRoleTagsProvider =
    StateNotifierProvider<MemberRoleTagsProvider, List<String>>((ref) {
  return MemberRoleTagsProvider();
});

class MemberRoleTagsProvider extends StateNotifier<List<String>> {
  MemberRoleTagsProvider() : super([]);

  void setRoleTagsWithFilter(Map<String, AsyncValue<List<bool>>> data) {
    List<String> newRoleTags = [];
    data.forEach((key, value) {
      value.maybeWhen(data: (d) {
        if (d[0]) {
          newRoleTags.add(key);
        }
      }, orElse: () {});
    });
    state = newRoleTags;
  }
}
