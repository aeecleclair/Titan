import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/advert/providers/advert_list_provider.dart';
import 'package:titan/advert/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> advertProviders =
    {
      "advert": Tuple2(AdvertRouter.root, [advertListProvider]),
    };
