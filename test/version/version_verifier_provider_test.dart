import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/version/class/version.dart';
import 'package:titan/version/providers/version_verifier_provider.dart';
import 'package:titan/version/repositories/version_repository.dart';

class MockVersionRepository extends Mock implements VersionRepository {}

void main() {
  late VersionRepository versionRepository;
  late VersionVerifierNotifier versionVerifierNotifier;

  setUp(() {
    versionRepository = MockVersionRepository();
    versionVerifierNotifier = VersionVerifierNotifier(
      versionRepository: versionRepository,
    );
  });

  group('VersionVerifierNotifier', () {
    test('should return AsyncLoading when initialized', () {
      expect(versionVerifierNotifier.state, isA<AsyncLoading>());
    });

    test(
      'should return AsyncValue<Version> when loadVersion is called',
      () async {
        final version = Version(
          version: '1.0.0',
          minimalTitanVersion: 1,
          ready: true,
        );
        when(
          () => versionRepository.getVersion(),
        ).thenAnswer((_) async => version);

        final result = await versionVerifierNotifier.loadVersion();

        expect(result, AsyncValue.data(version));
      },
    );

    test(
      'should return AsyncError when loadVersion throws an exception',
      () async {
        final exception = Exception('Failed to load version');
        when(() => versionRepository.getVersion()).thenThrow(exception);

        final result = await versionVerifierNotifier.loadVersion();

        expect(result, isA<AsyncError>());
      },
    );

    test(
      'should call getVersion method of VersionRepository when loadVersion is called',
      () async {
        when(() => versionRepository.getVersion()).thenAnswer(
          (_) async =>
              Version(version: '1.0.0', minimalTitanVersion: 1, ready: true),
        );

        await versionVerifierNotifier.loadVersion();

        verify(() => versionRepository.getVersion()).called(1);
      },
    );
  });
}
