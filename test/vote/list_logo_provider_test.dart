import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/providers/list_logo_provider.dart';
import 'package:myecl/vote/providers/list_logos_provider.dart';
import 'package:myecl/vote/repositories/list_logo_repository.dart';

class MockListLogoRepository extends Mock implements ListLogoRepository {}

class MockListLogoNotifier extends Mock implements ListLogoNotifier {}

void main() {
  late ListLogoRepository repository;
  late ListLogoNotifier notifier;
  late ListLogoProvider provider;

  setUp(() {
    repository = MockListLogoRepository();
    notifier = MockListLogoNotifier();
    provider = ListLogoProvider(
      listLogoRepository: repository,
      listLogosNotifier: notifier,
    );
  });

  group('ListLogoProvider', () {
    test('initial state is loading', () {
      expect(provider.state, isA<AsyncLoading>());
    });

    test('getLogo returns Image', () async {
      const id = '123';
      final image = Image.network('https://example.com/image.png');
      when(() => repository.getListLogo(id)).thenAnswer((_) async => image);

      final result = await provider.getLogo(id);

      expect(result, equals(image));
    });

    test('updateLogo returns Image', () async {
      const id = '123';
      Uint8List bytes = Uint8List(0);
      final image = Image.network('https://example.com/image.png');
      when(() => repository.addListLogo(bytes, id))
          .thenAnswer((_) async => image);

      final result = await provider.updateLogo(id, bytes);

      expect(result, equals(image));
    });
  });
}
