import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/vote/providers/section_vote_count_provide.dart';
import 'package:titan/vote/repositories/section_vote_count_repository.dart';

class MockSectionVoteCountRepository extends Mock
    implements SectionVoteCountRepository {}

void main() {
  late SectionVoteCountRepository repository;
  late SectionVoteCountNotifier notifier;

  setUp(() {
    repository = MockSectionVoteCountRepository();
    notifier = SectionVoteCountNotifier(repository: repository);
  });

  group('SectionVoteCountNotifier', () {
    test('initial state is AsyncLoading', () {
      expect(notifier.state, isA<AsyncLoading>());
    });

    test('loadCount returns AsyncValue<int>', () async {
      const id = '123';
      const count = 5;
      when(
        () => repository.getSectionVoteCount(id),
      ).thenAnswer((_) async => count);

      final result = await notifier.loadCount(id);

      expect(result, isA<AsyncValue<int>>());
    });

    test('loadCount returns AsyncError if repository throws', () async {
      const id = '123';
      final error = Exception('oops');
      when(() => repository.getSectionVoteCount(id)).thenThrow(error);

      final result = await notifier.loadCount(id);

      expect(result, isA<AsyncError>());
    });
  });
}
