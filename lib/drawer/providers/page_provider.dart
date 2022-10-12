import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ModuleType { home, settings, amap, loan, booking, admin, event, vote }

class PageNotifier extends StateNotifier<ModuleType> {
  PageNotifier() : super(ModuleType.admin);

  void setPage(ModuleType i) {
    state = i;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, ModuleType>((ref) {
  return PageNotifier();
});
