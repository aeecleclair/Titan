import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/admin/providers/module_root_list_provider.dart';
import 'package:myecl/admin/providers/module_visibility_list_provider.dart';

final allModuleVisibilityList = Provider<List<ModuleVisibility>>((ref) {
  return ref
      .watch(moduleVisibilityListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});

final allMyModuleRootList = Provider<List<String>>((ref) {
  return ref
      .watch(moduleRootListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
