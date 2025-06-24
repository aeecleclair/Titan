import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';

class MainPageIndexNotifier extends StateNotifier<int> {
  int startPage = 0;
  MainPageIndexNotifier(super.i);

  void setMainPageIndex(int event) {
    state = event;
  }

  void setStartPage(int page) {
    startPage = page;
  }

  void reset() {
    state = startPage;
  }
}

final mainPageIndexProvider = StateNotifierProvider<MainPageIndexNotifier, int>(
  (ref) {
    final sessionList = ref.watch(sessionListProvider);
    return sessionList.maybeWhen(
      data: (data) {
        if (data.isEmpty) {
          return MainPageIndexNotifier(0);
        }
        data.sort((a, b) => a.start.compareTo(b.start));
        final now = DateTime.now();
        final centralElement =
            data.indexWhere((element) => element.start.isAfter(now)) %
            data.length;
        final notifier = MainPageIndexNotifier(centralElement);
        notifier.setStartPage(centralElement);
        return notifier;
      },
      orElse: () {
        return MainPageIndexNotifier(0);
      },
    );
  },
);
