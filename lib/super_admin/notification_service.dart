import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/super_admin/router.dart';
import 'package:titan/router.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> adminProviders =
    {
      "user": Tuple2(AppRouter.root, [asyncUserProvider]),
      "userGroups": Tuple2(AppRouter.root, [
        allGroupListProvider,
        asyncUserProvider,
      ]),
      "groups": Tuple2(SuperAdminRouter.root, [allGroupListProvider]),
    };
