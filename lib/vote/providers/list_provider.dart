import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class ListNotifier extends StateNotifier<ListReturn> {
  ListNotifier() : super(ListReturn.fromJson({}));

  void setId(ListReturn p) {
    state = p;
  }
}

final listProvider = StateNotifierProvider<ListNotifier, ListReturn>((ref) {
  return ListNotifier();
});
