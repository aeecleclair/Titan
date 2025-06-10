import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';
import 'package:titan/ph/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> phProviders = {
  "ph": Tuple2(
    PhRouter.root, // La page principale du module ph
    [phListProvider], // Le provider de la liste des sessions
  ),
};
