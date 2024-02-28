import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/function.dart';

final associationMemberSortedListProvider =
    Provider<List<CompleteMember>>((ref) {
  final memberListProvider = ref.watch(associationMemberListProvider);
  final association = ref.watch(associationProvider);
  final roleTagsProvider = ref.watch(rolesTagsProvider);
  return memberListProvider.maybeWhen(
      data: (members) {
        return roleTagsProvider.maybeWhen(
            data: (roleTags) => sortedMembers(
                  members,
                  association.id,
                  roleTags.keys.toList(),
                ),
            orElse: () => members);
      },
      orElse: () => []);
});
