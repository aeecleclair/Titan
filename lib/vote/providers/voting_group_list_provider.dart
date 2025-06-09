import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/admin/class/simple_group.dart';
import 'package:myemapp/admin/providers/group_list_provider.dart';
import 'package:myemapp/vote/providers/voter_list_provider.dart';

final votingGroupListProvider = Provider<List<SimpleGroup>>((ref) {
  final votingGroupList = ref.watch(voterListProvider);
  final groups = ref.watch(allGroupListProvider);
  return votingGroupList.maybeWhen(
    data: (voters) => groups.maybeWhen(
      data: (groups) =>
          groups.where((g) => voters.any((v) => v.groupId == g.id)).toList(),
      orElse: () => [],
    ),
    orElse: () => [],
  );
});
