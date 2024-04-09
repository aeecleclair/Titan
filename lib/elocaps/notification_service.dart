import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>>
    elocapsProviders = {
  "game": Tuple2(
    ElocapsRouter.root + ElocapsRouter.history,
    [playerHistoProvider],
  ),
};
