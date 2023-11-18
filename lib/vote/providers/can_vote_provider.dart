import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/vote/providers/voting_group_list_provider.dart';

final canVoteProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  final votingGroupList = ref.watch(votingGroupListProvider);
  final myGroupIds = me.groups!
      .map((e) => e.id)
      .toList();
  return votingGroupList.any((e) => myGroupIds.contains(e.id));
});
