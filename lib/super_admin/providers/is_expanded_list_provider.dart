import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/super_admin/class/module_visibility.dart';
import 'package:titan/super_admin/providers/module_visibility_list_provider.dart';

class IsExpandedListProvider extends StateNotifier<List<bool>> {
  IsExpandedListProvider(List<ModuleVisibility> modules)
    : super(List.generate(modules.length, (index) => false));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }
}

final isExpandedListProvider =
    StateNotifierProvider<IsExpandedListProvider, List<bool>>((ref) {
      final modules = ref.read(moduleVisibilityListProvider);
      return modules.maybeWhen(
        data: (data) => IsExpandedListProvider(data),
        orElse: () {
          return IsExpandedListProvider([]);
        },
      );
    });
