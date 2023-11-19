import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/class/result.dart';
import 'package:myecl/vote/providers/result_provider.dart';
import 'package:myecl/vote/repositories/result_repository.dart';

class MockResultRepository extends Mock implements ResultRepository {}

void main() {
  late MockResultRepository mockResultRepository;
  late ResultNotifier resultNotifier;

  setUp(() {
    mockResultRepository = MockResultRepository();
    resultNotifier = ResultNotifier(resultRepository: mockResultRepository);
  });

  group('ResultNotifier', () {
    final result = Result.empty().copyWith(id: '1');

    test('should load result successfully', () async {
      when(() => mockResultRepository.getResult())
          .thenAnswer((_) async => [result]);

      final resultState = await resultNotifier.loadResult();

      expect(
          resultState.when(
            data: (data) => data,
            loading: () => [],
            error: (_, __) => [],
          ),
          [result]);
    });

    test('should return error when loading result fails', () async {
      when(() => mockResultRepository.getResult()).thenThrow(Exception());

      final resultState = await resultNotifier.loadResult();

      expect(resultState, isA<AsyncError>());
    });
  });
}
