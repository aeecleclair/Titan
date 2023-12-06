import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

class SelectedContenderProvider extends StateNotifier<ListReturn> {
  SelectedContenderProvider(List<dynamic> p) : super(ListReturn.fromJson({}));

  void changeSelection(ListReturn s) {
    state = s;
  }

  void clear() {
    state = ListReturn.fromJson({});
  }
}

final selectedContenderProvider =
    StateNotifierProvider<SelectedContenderProvider, ListReturn>((ref) {
  final contenderList = ref.watch(sectionsProvider);
  final contenders = [];
  contenderList.maybeWhen(
    data: (list) => contenders.addAll(list),
    orElse: () {},
  );
  return SelectedContenderProvider(contenders);
});
