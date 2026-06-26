import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class ListNotifier extends Notifier<ListReturn> {
  @override
  ListReturn build() {
    return ListReturn.empty();
  }

  void setId(ListReturn p) {
    state = p;
  }
}

final listProvider = NotifierProvider<ListNotifier, ListReturn>(
  ListNotifier.new,
);
