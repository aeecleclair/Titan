import 'dart:convert';
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

    test('readCache returns empty string if key not found', () async {
      when(() => mockStorage.read(key: 'test'))
          .thenAnswer((_) => Future.value(null));
      final result = await cacheManager.readCache('test');
      expect(result, '');
    });

    test('readCache returns value if key found', () async {
      when(() => mockStorage.read(key: 'test'))
          .thenAnswer((_) => Future.value('value'));
      final result = await cacheManager.readCache('test');
      expect(result, 'value');
    });
    
    test('readImage returns empty Uint8List if key not found', () async {
      when(() => mockStorage.read(key: 'test'))
          .thenAnswer((_) => Future.value(null));
      final result = await cacheManager.readImage('test');
      expect(result, Uint8List(0));
    });

    test('readImage returns Uint8List if key found', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(() => mockStorage.read(key: 'test'))
          .thenAnswer((_) => Future.value(json.encode(bytes)));
      final result = await cacheManager.readImage('test');
      expect(result, bytes);
    });
  });
}
