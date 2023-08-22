import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/ui/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, StateNotifierProvider>> advertProviders = {
    "session": Tuple2(
      AdvertRouter.root,
      advertListProvider,
    )
};