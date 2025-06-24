import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/module_root_list_provider.dart';

final allMyModuleRootList = Provider<List<String>>((ref) {
  return ref
      .watch(moduleRootListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
