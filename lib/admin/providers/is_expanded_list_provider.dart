import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/permission_name_list_provider.dart';

class IsExpandedListProvider extends StateNotifier<List<bool>> {
  IsExpandedListProvider(List<String> permissionsNames)
    : super(List.generate(permissionsNames.length, (index) => false));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }
}

final isExpandedListProvider =
    StateNotifierProvider<IsExpandedListProvider, List<bool>>((ref) {
      final modules = ref.read(permissionsNamesListProvider);
      return modules.maybeWhen(
        data: (data) => IsExpandedListProvider(data),
        orElse: () {
          return IsExpandedListProvider([]);
        },
      );
    });
