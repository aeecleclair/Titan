import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class ContenderNotifier extends StateNotifier<ListReturn> {
  ContenderNotifier() : super(ListReturn.fromJson({}));

  void setId(ListReturn p) {
    state = p;
  }
}

final contenderProvider =
    StateNotifierProvider<ContenderNotifier, ListReturn>((ref) {
  return ContenderNotifier();
});
