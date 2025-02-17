import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';

class SelectedSortingTypeNotifier extends StateNotifier<SortingType> {
  SelectedSortingTypeNotifier() : super(SortingType.best);

  void setSortingType(SortingType sortingType) {
    state = sortingType;
  }
}

final selectedSortingTypeProvider =
    StateNotifierProvider<SelectedSortingTypeNotifier, SortingType>((ref) {
  return SelectedSortingTypeNotifier();
});
