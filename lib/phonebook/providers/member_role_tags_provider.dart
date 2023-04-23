import 'package:flutter_riverpod/flutter_riverpod.dart';


final memberRolesTagsProvider = StateNotifierProvider<MemberRolesTagsProvider, List<String>>((ref) {
  return MemberRolesTagsProvider();
});

class MemberRolesTagsProvider extends StateNotifier<List<String>> {
  MemberRolesTagsProvider() : super([]);

  void setRoleTagsWithFilter(List<String> i, List<bool> filter) {
    List<String> newRoleTags = [];
    for (int i = 0; i < filter.length; i++) {
      if (filter[i]) {
        newRoleTags.add(state[i]);
      }
    }
    state = newRoleTags;
  }
}