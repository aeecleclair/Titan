import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/drawer/class/module.dart';

void main() {
  group('Module', () {
    test(
      'copy method should return a new Module object with updated properties',
      () {
        final module = Module(
          name: 'Calendar',
          icon: const Left(HeroIcons.calendar),
          selected: true,
          root: '',
        );

        final copiedModule = module.copy(
          name: 'Settings',
          icon: const Left(HeroIcons.cog),
          selected: false,
          root: '/test',
        );

        expect(copiedModule.name, 'Settings');
        expect(copiedModule.icon, const Left(HeroIcons.cog));
        expect(copiedModule.root, '/test');
        expect(copiedModule.selected, false);
      },
    );
  });
}
