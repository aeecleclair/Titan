import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/tools/function.dart';

final associationMemberSortedListProvider = Provider<List<CompleteMember>>((
  ref,
) {
  final memberListProvider = ref.watch(associationMemberListProvider);
  final association = ref.watch(associationProvider);
  return memberListProvider.maybeWhen(
    data: (members) {
      return sortedMembers(members, association.id);
    },
    orElse: () => List<CompleteMember>.empty(),
  );
});
