import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/providers/section_vote_count_provide.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockSectionVoteCountRepository extends Mock implements Openapi {}

void main() {
  group('SectionVoteCountNotifier', () {
    late MockSectionVoteCountRepository mockRepository;
    late SectionVoteCountNotifier provider;
    final voteStats = VoteStats(sectionId: '1', count: 0);

    setUp(() {
      mockRepository = MockSectionVoteCountRepository();
      provider = SectionVoteCountNotifier(repository: mockRepository);
    });

    test('loadCount returns expected data', () async {
      when(
        () => mockRepository.campaignStatsSectionIdGet(
          sectionId: any(named: 'sectionId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          voteStats,
        ),
      );

      final result = await provider.loadCount('1');

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => null,
        ),
        voteStats,
      );
    });

    test('loadCount handles error', () async {
      when(
        () => mockRepository.campaignStatsSectionIdGet(
          sectionId: any(named: 'sectionId'),
        ),
      ).thenThrow(Exception('Failed to load count'));

      final result = await provider.loadCount('1');

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
