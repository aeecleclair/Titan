import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> phProviders = {
  "ph": Tuple2(
    // L'actionTable de la notification est "session"
    PhRouter.root, // La page principale du module ciné
    [phListProvider], // Le provider de la liste des sessions
  ),
};
