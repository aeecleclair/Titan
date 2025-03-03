import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class SelectedListProvider extends StateNotifier<ListReturn> {
  SelectedListProvider() : super(EmptyModels.empty<ListReturn>());

  void changeSelection(ListReturn s) {
    state = s;
  }

  void clear() {
    state = EmptyModels.empty<ListReturn>();
  }
}

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, ListReturn>((ref) {
  return SelectedListProvider();
});
