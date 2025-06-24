import 'package:flutter_test/flutter_test.dart';
import 'package:titan/version/class/version.dart';

void main() {
  group('Testing Version class', () {
    test('Should return a Version', () {
      final version = Version.empty();
      expect(version, isA<Version>());
      expect(version.version, '');
      expect(version.ready, false);
      expect(version.minimalTitanVersion, 0);
    });

    test('Should return a Version', () {
      final version = Version(
        version: '1.0.0',
        ready: true,
        minimalTitanVersion: 1,
      );
      expect(version, isA<Version>());
      expect(version.version, '1.0.0');
      expect(version.ready, true);
      expect(version.minimalTitanVersion, 1);
    });

    test('Should parse a Version', () {
      final version = Version.fromJson({
        "version": "1.0.0",
        "ready": true,
        "minimal_titan_version_code": 1,
      });
      expect(version, isA<Version>());
      expect(version.version, '1.0.0');
      expect(version.ready, true);
      expect(version.minimalTitanVersion, 1);
    });

    test('Should return a correct json', () {
      final version = Version.fromJson({
        "version": "1.0.0",
        "ready": true,
        "minimal_titan_version_code": 1,
      });
      expect(version.toJson(), {
        "version": "1.0.0",
        "ready": true,
        "minimal_titan_version_code": 1,
      });
    });
  });
}
