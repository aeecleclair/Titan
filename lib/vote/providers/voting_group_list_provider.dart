import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/vote/providers/voter_list_provider.dart';

final votingGroupListProvider = Provider<List<SimpleGroup>>((ref) {
  final votingGroupList = ref.watch(voterListProvider);
  final groups = ref.watch(allGroupListProvider);
  return votingGroupList.when(
    data: (voters) => groups.when(
      data: (groups) => groups
          .where((g) => voters.any((v) => v.groupId == g.id))
          .toList(),
      error: (Object error, StackTrace? stackTrace) => [],
      loading: () => [],
    ),
    error: (Object error, StackTrace? stackTrace) => [],
    loading: () => [],
  );
});
