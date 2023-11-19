// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/page_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PageNotifier', () {
    test('PageNotifier setPage should update state', () {
      final notifier = PageNotifier(ModuleType.admin);
      notifier.setPage(ModuleType.settings);
      expect(notifier.state, ModuleType.settings);
    });
  });
}
