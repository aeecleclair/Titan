import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberRoleTagsProvider =
    StateNotifierProvider<MemberRoleTagsProvider, List<String>>((ref) {
      return MemberRoleTagsProvider();
    });

class MemberRoleTagsProvider extends StateNotifier<List<String>> {
  MemberRoleTagsProvider() : super([]);

  void setRoleTagsWithFilter(Map<String, AsyncValue<List<bool>>?> data) {
    List<String> newRoleTags = [];
    data.forEach((key, value) {
      value?.whenData((d) {
        if (d[0]) {
          newRoleTags.add(key);
        }
      });
    });
    state = newRoleTags;
  }

  void reset() {
    state = [];
  }
}
