import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/utils.dart';

class SelectedSortingScoreEntityNotifier extends StateNotifier<Entity> {
  SelectedSortingScoreEntityNotifier() : super(Entity.user);

  void setSortingPeriod(Entity e) {
    state = e;
  }
}

final selectedSortingScoreEntityProvider =
    StateNotifierProvider<SelectedSortingScoreEntityNotifier, Entity>((ref) {
  return SelectedSortingScoreEntityNotifier();
});
