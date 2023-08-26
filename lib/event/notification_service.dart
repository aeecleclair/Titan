import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/user_event_list_provider.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/home/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> eventProviders =
    {
  "userEvents": Tuple2(
    EventRouter.root,
    [eventEventListProvider, confirmedEventListProvider],
  ),
  "confirmedEvents": Tuple2(
    HomeRouter.root,
    [confirmedEventListProvider],
  ),
  "events": Tuple2(
    EventRouter.root + EventRouter.admin,
    [eventListProvider],
  )
};
