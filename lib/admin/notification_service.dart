import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/router.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider<dynamic, dynamic>>>>
    adminProviders = {
  "user": Tuple2(
    AppRouter.root,
    [asyncUserProvider],
  ),
  "userGroups": Tuple2(
    AppRouter.root,
    [allGroupListProvider, asyncUserProvider],
  ),
  "groups": Tuple2(
    AdminRouter.root,
    [allGroupListProvider],
  ),
};
