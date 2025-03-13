import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/vote/providers/voter_list_provider.dart';

final votingGroupListProvider = Provider<List<CoreGroupSimple>>((ref) {
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
