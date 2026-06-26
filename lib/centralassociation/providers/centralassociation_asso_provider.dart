import 'package:titan/centralassociation/class/asso.dart';
import 'package:titan/centralassociation/class/link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/centralassociation/repositories/asso_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class AssoNotifier extends ListNotifier<Asso> {
  final AssoRepository assoRepository = AssoRepository();

  List<Asso> allAssos = [];
  List<Link> allLinks = [];

  @override
  AsyncValue<List<Asso>> build() {
    initState();
    return const AsyncValue.loading();
  }

  Future<void> initState() async {
    allAssos = await assoRepository.getAssoList();
    allLinks = allAssos.expand((element) => element.linkList).toList();
    state = AsyncValue.data(allAssos);
  }
}

final assoProvider = NotifierProvider<AssoNotifier, AsyncValue<List<Asso>>>(
  AssoNotifier.new,
);
