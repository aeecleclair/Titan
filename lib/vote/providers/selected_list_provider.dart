import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class SelectedListProvider extends StateNotifier<ListReturn> {
  SelectedListProvider() : super(ListReturn.fromJson({}));

  void changeSelection(ListReturn s) {
    state = s;
  }

  void clear() {
    state = ListReturn.fromJson({});
  }
}

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, ListReturn>((ref) {
  return SelectedListProvider();
});
