import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/vote/providers/contender_logo_provider.dart';
import 'package:titan/vote/providers/contender_logos_provider.dart';
import 'package:titan/vote/repositories/contender_logo_repository.dart';

class MockContenderLogoRepository extends Mock
    implements ContenderLogoRepository {}

class MockContenderLogoNotifier extends Mock implements ContenderLogoNotifier {}

void main() {
  late ContenderLogoRepository repository;
  late ContenderLogoNotifier notifier;
  late ContenderLogoProvider provider;

  setUp(() {
    repository = MockContenderLogoRepository();
    notifier = MockContenderLogoNotifier();
    provider = ContenderLogoProvider(
      contenderLogoRepository: repository,
      contenderLogosNotifier: notifier,
    );
  });

  group('ContenderLogoProvider', () {
    test('initial state is loading', () {
      expect(provider.state, isA<AsyncLoading>());
    });

    test('getLogo returns Image', () async {
      const id = '123';
      final image = Image.network('https://example.com/image.png');
      when(
        () => repository.getContenderLogo(id),
      ).thenAnswer((_) async => image);

      final result = await provider.getLogo(id);

      expect(result, equals(image));
    });

    test('updateLogo returns Image', () async {
      const id = '123';
      Uint8List bytes = Uint8List(0);
      final image = Image.network('https://example.com/image.png');
      when(
        () => repository.addContenderLogo(bytes, id),
      ).thenAnswer((_) async => image);

      final result = await provider.updateLogo(id, bytes);

      expect(result, equals(image));
    });
  });
}
