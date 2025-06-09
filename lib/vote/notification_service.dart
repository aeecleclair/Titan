import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/vote/providers/contender_list_provider.dart';
import 'package:myemapp/vote/providers/result_provider.dart';
import 'package:myemapp/vote/providers/status_provider.dart';
import 'package:myemapp/vote/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> voteProviders = {
  "contender": Tuple2(VoteRouter.root, [contenderListProvider]),
  "status": Tuple2(VoteRouter.root, [statusProvider]),
  "userResults": Tuple2(VoteRouter.root, [statusProvider, resultProvider]),
  "results": Tuple2(VoteRouter.root + VoteRouter.admin, [
    statusProvider,
    resultProvider,
  ]),
};
