import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/cinema/repositories/session_poster_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionPosterRepository extends Mock
    implements SessionPosterRepository {}

void main() {
  group('SessionPosterProvider', () {
    late SessionPosterRepository repository;
    late SessionPosterProvider provider;

    setUp(() {
      repository = MockSessionPosterRepository();
      provider = SessionPosterProvider(repository: repository);
    });

    test('initial state is loading', () {
      expect(provider.state, isA<AsyncLoading<Image>>());
    });

    test('getLogo returns image from repository', () async {
      const id = '123';
      final image = Image.network('https://example.com/image.png');
      when(() => repository.getSessionLogo(id)).thenAnswer((_) async => image);

      final result = await provider.getLogo(id);

      expect(result, image);
      verify(() => repository.getSessionLogo(id)).called(1);
    });

    test('updateLogo returns image from repository', () async {
      const id = '123';
      Uint8List bytes = Uint8List(0);
      final image = Image.memory(bytes);
      when(() => repository.addSessionLogo(bytes, id))
          .thenAnswer((_) async => image);

      final result = await provider.updateLogo(id, bytes);

      expect(result, equals(image));
      verify(() => repository.addSessionLogo(bytes, id)).called(1);
    });
  });
}
