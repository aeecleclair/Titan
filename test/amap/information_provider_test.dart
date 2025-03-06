import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/providers/information_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class MockInformationRepository extends Mock implements Openapi {}

void main() {
  group('InformationNotifier', () {
    late MockInformationRepository informationRepository;
    late InformationNotifier informationNotifier;
    final information = Information(
      manager: 'manager',
      link: 'link',
      description: 'description',
    );

    setUp(() {
      informationRepository = MockInformationRepository();
      informationNotifier =
          InformationNotifier(informationRepository: informationRepository);
    });

    test('loadInformation should return information from repository', () async {
      when(() => informationRepository.amapInformationGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), information),
      );

      final result = await informationNotifier.loadInformation();

      expect(
        result.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        information,
      );
    });

    test('updateInformation should update information in repository and state',
        () async {
      when(
        () => informationRepository.amapInformationPatch(
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      informationNotifier.state = AsyncValue.data(information);

      final result = await informationNotifier.updateInformation(information);

      expect(result, true);
    });

    test('loadInformation should handle error', () async {
      when(() => informationRepository.amapInformationGet())
          .thenThrow(Exception('Error'));

      final result = await informationNotifier.loadInformation();

      expect(result, isA<AsyncError>());
    });

    test('updateInformation should handle error', () async {
      when(
        () => informationRepository.amapInformationPatch(
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));

      final result = await informationNotifier.updateInformation(information);

      expect(result, false);
    });
  });
}
