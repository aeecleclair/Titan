import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/providers/votes_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockVotesRepository extends Mock implements Openapi {}

void main() {
  group('VotesProvider', () {
    late MockVotesRepository mockRepository;
    late VotesProvider provider;
    final votes = VoteBase.fromJson({}).copyWith(listId: '1');

    setUp(() {
      mockRepository = MockVotesRepository();
      provider = VotesProvider(votesRepository: mockRepository);
    });

    test('addVote returns true when successful', () async {
      when(() => mockRepository.campaignVotesPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          votes,
        ),
      );

      final result = await provider.addVote(votes);

      expect(result, true);
    });

    test('addVote handles error', () async {
      when(() => mockRepository.campaignVotesPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add vote'));

      expect(() => provider.addVote(votes), throwsA(isA<Exception>()));
    });

    test('copy returns current state', () async {
      provider.state = AsyncValue.data([votes]);

      final result = await provider.copy();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [votes],
      );
    });
  });
}
