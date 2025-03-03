import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class ListNotifier extends StateNotifier<ListReturn> {
  ListNotifier() : super(EmptyModels.empty<ListReturn>());

  void setId(ListReturn p) {
    state = p;
  }
}

final listProvider = StateNotifierProvider<ListNotifier, ListReturn>((ref) {
  return ListNotifier();
});
