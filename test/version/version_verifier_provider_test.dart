import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/version/providers/version_verifier_provider.dart';

class MockVersionRepository extends Mock implements Openapi {}

void main() {
  group('VersionVerifierNotifier', () {
    late MockVersionRepository mockRepository;
    late ProviderContainer container;
    late VersionVerifierNotifier provider;
    final version = CoreInformation(
      ready: true,
      version: '1.0.0',
      minimalTitanVersionCode: 1,
    );

    setUp(() async {
      mockRepository = MockVersionRepository();
      when(() => mockRepository.informationGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('{}', 200),
          CoreInformation(
            ready: true,
            version: '1.0.0',
            minimalTitanVersionCode: 1,
          ),
        ),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(versionVerifierProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadVersion returns expected data', () async {
      when(() => mockRepository.informationGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), version),
      );

      final result = await provider.loadVersion();

      expect(
        result.maybeWhen(data: (data) => data, orElse: () => null),
        version,
      );
    });

    test('loadVersion handles error', () async {
      when(
        () => mockRepository.informationGet(),
      ).thenThrow(Exception('Failed to load version'));

      final result = await provider.loadVersion();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });
  });
}
