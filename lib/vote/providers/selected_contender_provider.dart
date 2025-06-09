import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/vote/class/contender.dart';
import 'package:myemapp/vote/providers/sections_provider.dart';

final selectedContenderProvider =
    StateNotifierProvider<SelectedContenderProvider, Contender>((ref) {
      final contenderList = ref.watch(sectionsProvider);
      final contenders = [];
      contenderList.maybeWhen(
        data: (list) => contenders.addAll(list),
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
