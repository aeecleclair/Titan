import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';
import 'package:titan/cinema/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> cinemaProviders =
    {
      "session": Tuple2(CinemaRouter.root, [sessionListProvider]),
    };
