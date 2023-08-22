import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, StateNotifierProvider>> voteProviders = {
  "contender": Tuple2(
    VoteRouter.root,
    pretendanceListProvider,
  ),
  "status": Tuple2(
    VoteRouter.root,
    statusProvider,
  ),
  "userResults": Tuple2(
    VoteRouter.root,
    statusProvider,
  ),
  "results": Tuple2(
    VoteRouter.root + VoteRouter.admin,
    statusProvider,
  ),
};
