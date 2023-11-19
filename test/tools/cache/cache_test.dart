import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/tools/cache/cache_manager.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('CacheManager', () {
    late CacheManager cacheManager;
    late MockFlutterSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      cacheManager = CacheManager(storage: mockStorage);
    });

    test('readCache returns empty string if key does not exist', () async {
      when(() => mockStorage.read(key: 'non-existent-key'))
          .thenAnswer((_) async => null);

      final result = await cacheManager.readCache('non-existent-key');

      expect(result, '');
    });

    test('readCache returns value if key exists', () async {
      when(() => mockStorage.read(key: 'existing-key'))
          .thenAnswer((_) async => 'existing-value');

      final result = await cacheManager.readCache('existing-key');

      expect(result, 'existing-value');
    });
    test('readImage returns empty Uint8List if key does not exist', () async {
      when(() => mockStorage.read(key: 'non-existent-image-key'))
          .thenAnswer((_) async => null);

      final result = await cacheManager.readImage('non-existent-image-key');

      expect(result, Uint8List(0));
    });

    test('readImage returns Uint8List if key exists', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(() => mockStorage.read(key: 'existing-image-key'))
          .thenAnswer((_) async => bytes.toString());

      final result = await cacheManager.readImage('existing-image-key');

      expect(result, bytes);
    });
  });
}
