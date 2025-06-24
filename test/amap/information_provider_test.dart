import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/class/information.dart';
import 'package:titan/amap/providers/information_provider.dart';
import 'package:titan/amap/repositories/information_repository.dart';

class MockInformationRepository extends Mock implements InformationRepository {}

void main() {
  group('InformationNotifier', () {
    late InformationRepository informationRepository;
    late InformationNotifier informationNotifier;

    setUp(() {
      informationRepository = MockInformationRepository();
      informationNotifier = InformationNotifier(
        informationRepository: informationRepository,
      );
    });

    test('loadInformation', () async {
      final information = Information.empty();
      when(
        () => informationRepository.getInformation(),
      ).thenAnswer((_) async => information);

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

    test('createInformation', () async {
      final information = Information.empty();
      when(
        () => informationRepository.createInformation(information),
      ).thenAnswer((_) async => information);
      informationNotifier.state = AsyncValue.data(information);

      final result = await informationNotifier.createInformation(information);

      expect(result, true);
    });

    test('updateInformation', () async {
      final information = Information.empty();
      when(
        () => informationRepository.updateInformation(information),
      ).thenAnswer((_) async => true);
      informationNotifier.state = AsyncValue.data(information);

      final result = await informationNotifier.updateInformation(information);

      expect(result, true);
    });

    test('deleteInformation', () async {
      final information = Information.empty();
      when(
        () => informationRepository.deleteInformation(information.manager),
      ).thenAnswer((_) async => true);
      informationNotifier.state = AsyncValue.data(information);

      final result = await informationNotifier.deleteInformation(information);

      expect(result, true);
    });
  });
}
