import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, StateNotifierProvider>> cinemaProviders = {
    "session": Tuple2(
      CinemaRouter.root,
      sessionListProvider,
    )
};