import 'package:myecl/centralassos/class/asso.dart';
import 'package:myecl/centralassos/class/link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/centralassos/repositories/asso_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssoNotifier extends ListNotifier<Asso> {
  AssoRepository assoRepository = AssoRepository();
  AssoNotifier() : super(const AsyncValue.loading());

  late List<Asso> allAssos = [];
  late List<Link> allLinks = [];

  initState() async {
    allAssos = await assoRepository.getAssoList();
    allLinks = allAssos.expand((element) => element.linkList).toList();
    state = AsyncValue.data(allAssos);
  }
}

final assoProvider =
    StateNotifierProvider<AssoNotifier, AsyncValue<List<Asso>>>((ref) {
  AssoNotifier notifier = AssoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    await notifier.initState();
  });
  return notifier;
});
