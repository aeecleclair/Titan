// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/modules_provider.dart';

void main() {
  group('ModuleListNotifier', () {
    test('select method should select the correct module', () {
      final module1 = Module.empty().copy(name: 'Module 1', selected: false);
      final module2 = Module.empty().copy(name: 'Module 2', selected: false);
      final module3 = Module.empty().copy(name: 'Module 3', selected: false);
      final moduleList = [module1, module2, module3];
      final notifier = ModuleListNotifier(moduleList);

      notifier.select(1);

      expect(notifier.state[0].selected, false);
      expect(notifier.state[1].selected, true);
      expect(notifier.state[2].selected, false);
    });
  });
}
