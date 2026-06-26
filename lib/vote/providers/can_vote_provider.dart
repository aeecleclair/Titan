import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/vote/providers/voter_list_provider.dart';

final canVoteProvider = Provider<bool>((ref) {
  final me = ref.watch(userProvider);
  final voters = ref.watch(voterListProvider);
  final myGroupIds = (me.groups ?? []).map((e) => e.id).toList();
  return voters.maybeWhen(
    data: (permission) =>
        permission.groups.any((id) => myGroupIds.contains(id)),
    orElse: () => false,
  );
});
