// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

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
      expect(provider.state, isA<AsyncLoading>());
    });

    test('getLogo returns image from repository', () async {
      const id = '123';
      final image = Image.network('https://example.com/image.png');
      when(() => repository.getPretendenceLogo(id))
          .thenAnswer((_) async => image);

      final result = await provider.getLogo(id);

      expect(result, image);
      verify(() => repository.getPretendenceLogo(id)).called(1);
    });

    test('updateLogo returns image from repository', () async {
      const id = '123';
      const path = '/path/to/image.png';
      final image = Image.file(File(path));
      when(() => repository.addPretendenceLogo(path, id))
          .thenAnswer((_) async => image);

      final result = await provider.updateLogo(id, path);

      expect(result, equals(image));
      verify(() => repository.addPretendenceLogo(path, id)).called(1);
    });
  });
}
