import 'package:flutter_test/flutter_test.dart';
import 'package:titan/cinema/providers/main_page_index_provider.dart';

void main() {
  group('MainPageIndexNotifier', () {
    test('MainPageIndexNotifier sets correct initial state', () {
      final notifier = MainPageIndexNotifier(2);
      expect(notifier.state, 2);
    });

    test('MainPageIndexNotifier setMainPageIndex updates state', () {
      final notifier = MainPageIndexNotifier(2);
      notifier.setMainPageIndex(4);
      expect(notifier.state, 4);
    });

    test('MainPageIndexNotifier setStartPage updates startpage', () {
      final notifier = MainPageIndexNotifier(2);
      notifier.setStartPage(3);
      expect(notifier.startPage, 3);
    });

    test('MainPageIndexNotifier reset sets state to startpage', () {
      final notifier = MainPageIndexNotifier(2);
      notifier.setMainPageIndex(4);
      notifier.setStartPage(3);
      notifier.reset();
      expect(notifier.state, 3);
    });
  });
}
