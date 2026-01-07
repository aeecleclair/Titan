import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/vote/tools/constants.dart';

final isVoteAdminProvider = StateProvider<bool>((ref) {
  return hasUserPermission(ref, VotePermissionConstants.manageVotes);
});

final canVoteProvider = StateProvider<bool>((ref) {
  return hasUserPermission(ref, VotePermissionConstants.vote);
});
