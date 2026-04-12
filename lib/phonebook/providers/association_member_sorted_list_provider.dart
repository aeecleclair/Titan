import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/tools/function.dart';

final associationMemberSortedListProvider = Provider<List<CompleteMember>>((
  ref,
) {
  final memberListProvider = ref.watch(associationMemberListProvider);
  final association = ref.watch(associationProvider);
  return memberListProvider.maybeWhen(
    data: (members) {
      return sortedMembers(members, association.id, association.mandateYear);
    },
    orElse: () => List<CompleteMember>.empty(),
  );
});
