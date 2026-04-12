import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/vote/tools/constants.dart';

final isVoteAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, VotePermissionConstants.manageVotes);
});

final canVoteProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, VotePermissionConstants.vote);
});
