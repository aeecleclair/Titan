import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/settings/providers/first_page_provider.dart';


class PageNotifier extends StateNotifier<ModuleType> {
  PageNotifier(ModuleType type) : super(type);

  void setPage(ModuleType i) {
    state = i;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, ModuleType>((ref) {
  final firstPage = ref.watch(firstPageProvider);
  return PageNotifier(firstPage);
});
