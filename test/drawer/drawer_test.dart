import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';

void main() {
  group('Module', () {
    test(
        'copy method should return a new Module object with updated properties',
        () {
      final module = Module(
        name: 'Calendar',
        icon: HeroIcons.calendar,
        page: ModuleType.calendar,
        selected: true,
      );

      final copiedModule = module.copy(
        name: 'Settings',
        icon: HeroIcons.cog,
        page: ModuleType.settings,
        selected: false,
      );

      expect(copiedModule.name, 'Settings');
      expect(copiedModule.icon, HeroIcons.cog);
      expect(copiedModule.page, ModuleType.settings);
      expect(copiedModule.selected, false);
    });

    test('empty constructor should create a Module object with default values',
        () {
      final emptyModule = Module.empty();

      expect(emptyModule.name, '');
      expect(emptyModule.icon, HeroIcons.academicCap);
      expect(emptyModule.page, ModuleType.calendar);
      expect(emptyModule.selected, false);
    });
  });
}
