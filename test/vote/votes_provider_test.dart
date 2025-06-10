import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/vote/class/votes.dart';
import 'package:titan/vote/providers/votes_provider.dart';
import 'package:titan/vote/repositories/votes_repository.dart';

class MockVotesRepository extends Mock implements VotesRepository {}

void main() {
  group('VotesProvider', () {
    late VotesProvider votesProvider;
    late MockVotesRepository mockVotesRepository;

    setUp(() {
      mockVotesRepository = MockVotesRepository();
      votesProvider = VotesProvider(votesRepository: mockVotesRepository);
    });

    test('initial state is loading', () {
      expect(votesProvider.state, isA<AsyncValue<List<Votes>>>());
    });

    test('addVote returns true when successful', () async {
      final votes = Votes.empty();
      when(
        () => mockVotesRepository.addVote(votes),
      ).thenAnswer((_) async => votes);

      final result = await votesProvider.addVote(votes);

      expect(result, true);
    });

    test('addVote rethrows error when unsuccessful', () async {
      final votes = Votes.empty();
      final error = Exception('Failed to add vote');
      when(() => mockVotesRepository.addVote(votes)).thenThrow(error);

      expect(() => votesProvider.addVote(votes), throwsA(error));
    });

    test('removeVote deletes all votes', () async {
      when(
        () => mockVotesRepository.removeVote(),
      ).thenAnswer((_) async => true);
      votesProvider.state = const AsyncValue<List<Votes>>.data([]);
      final result = await votesProvider.removeVote();

      expect(result, true);
      expect(votesProvider.state, isA<AsyncValue<List<Votes>>>());
    });

    test('copy returns current state', () async {
      const currentState = AsyncValue<List<Votes>>.data([]);
      votesProvider.state = currentState;

      final result = await votesProvider.copy();

      expect(result, currentState);
    });
  });
}
