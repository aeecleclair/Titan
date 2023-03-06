import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';

class MainPageIndexNotifier extends StateNotifier<int> {
  int startpage = 0;
  MainPageIndexNotifier(int i) : super(i);

  void setMainPageIndex(int event) {
    state = event;
  }

  void setStartPage(int page) {
    startpage = page;
  }

  void reset() {
    state = startpage;
  }
}

final mainPageIndexProvider =
    StateNotifierProvider<MainPageIndexNotifier, int>((ref) {
  final sessionList = ref.watch(sessionListProvider);
  return sessionList.when(data: (data) {
    data.sort((a, b) => a.start.compareTo(b.start));
    final now = DateTime.now();
    final centralElement =
        data.indexWhere((element) => element.start.isAfter(now)) % data.length;
    final notifier = MainPageIndexNotifier(centralElement);
    notifier.setStartPage(centralElement);
    return notifier;
  }, error: (Object error, StackTrace stackTrace) {
    return MainPageIndexNotifier(0);
  }, loading: () {
    return MainPageIndexNotifier(0);
  });
});
