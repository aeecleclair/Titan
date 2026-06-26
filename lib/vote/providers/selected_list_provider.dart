import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SelectedListProvider extends Notifier<ListReturn> {
  @override
  ListReturn build() {
    return ListReturn.empty();
  }

  void changeSelection(ListReturn s) {
    state = s;
  }

  void clear() {
    state = ListReturn.empty();
  }
}

final selectedListProvider = NotifierProvider<SelectedListProvider, ListReturn>(
  SelectedListProvider.new,
);
