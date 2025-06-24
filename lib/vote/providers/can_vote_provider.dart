import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/vote/providers/voter_list_provider.dart';

final canVoteProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  final votingGroupList = ref.watch(voterListProvider);
  final myGroupIds = me.groups.map((e) => e.id).toList();
  return votingGroupList.maybeWhen(
    data: (voters) => voters.any((e) => myGroupIds.contains(e.groupId)),
    orElse: () => false,
  );
});
