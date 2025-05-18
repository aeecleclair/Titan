import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockVersionRepository extends Mock implements Openapi {}

void main() {
  group('VersionVerifierNotifier', () {
    late MockVersionRepository mockRepository;
    late VersionVerifierNotifier provider;
    final version = CoreInformation(
      ready: true,
      version: '1.0.0',
      minimalTitanVersionCode: 1,
    );

    setUp(() {
      mockRepository = MockVersionRepository();
      provider = VersionVerifierNotifier(versionRepository: mockRepository);
    });

    test('loadVersion returns expected data', () async {
      when(() => mockRepository.informationGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          version,
        ),
      );

      final result = await provider.loadVersion();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => null,
        ),
        version,
      );
    });

    test('loadVersion handles error', () async {
      when(() => mockRepository.informationGet())
          .thenThrow(Exception('Failed to load version'));

      final result = await provider.loadVersion();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });
  });
}
