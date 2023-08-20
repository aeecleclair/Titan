import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/admin/providers/module_visibilities_list_provider.dart';

final allModuleVisibilitiesList = Provider<List<ModuleVisibilities>>((ref) {
  return ref
      .watch(moduleVisibilitiesListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
