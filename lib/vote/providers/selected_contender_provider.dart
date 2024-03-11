import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

final selectedContenderProvider =
    StateNotifierProvider<SelectedContenderProvider, Contender>((ref) {
  final contenderList = ref.watch(sectionsProvider);
  final contenders = List<Section>.empty(growable: true);
  contenderList.maybeWhen(
    data: (list) => contenders.addAll(Iterable.castFrom(list)),
    orElse: () {},
  );
  return SelectedContenderProvider(contenders);
});

class SelectedContenderProvider extends StateNotifier<Contender> {
  SelectedContenderProvider(List<dynamic> p) : super(Contender.empty());

  void changeSelection(Contender s) {
    state = s;
  }

  void clear() {
    state = Contender.empty();
  }
}
