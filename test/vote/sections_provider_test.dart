import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockSectionRepository extends Mock implements Openapi {}

void main() {
  group('SectionNotifier', () {
    late MockSectionRepository mockRepository;
    late SectionNotifier provider;
    final sections = [
      EmptyModels.empty<SectionComplete>().copyWith(id: '1'),
      EmptyModels.empty<SectionComplete>().copyWith(id: '2'),
    ];
    final newSection = EmptyModels.empty<SectionComplete>().copyWith(id: '3');
    final newSectionBase =
        SectionBase(name: newSection.name, description: newSection.description);

    setUp(() {
      mockRepository = MockSectionRepository();
      provider = SectionNotifier(sectionRepository: mockRepository);
    });

    test('loadSectionList returns expected data', () async {
      when(() => mockRepository.campaignSectionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sections,
        ),
      );

      final result = await provider.loadSectionList();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        sections,
      );
    });

    test('loadSectionList handles error', () async {
      when(() => mockRepository.campaignSectionsGet())
          .thenThrow(Exception('Failed to load sections'));

      final result = await provider.loadSectionList();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addSection adds a section to the list', () async {
      when(() => mockRepository.campaignSectionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sections,
        ),
      );
      when(() => mockRepository.campaignSectionsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newSection,
        ),
      );

      await provider.loadSectionList();
      final result = await provider.addSection(newSectionBase);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...sections, newSection],
      );
    });

    test('addSection handles error', () async {
      when(() => mockRepository.campaignSectionsPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add section'));

      final result = await provider.addSection(newSectionBase);

      expect(result, false);
    });

    test('deleteSection removes a section from the list', () async {
      when(() => mockRepository.campaignSectionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sections,
        ),
      );
      when(
        () => mockRepository.campaignSectionsSectionIdDelete(
          sectionId: any(named: 'sectionId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      await provider.loadSectionList();
      final result = await provider.deleteSection(sections.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        sections.skip(1).toList(),
      );
    });

    test('deleteSection handles error', () async {
      when(
        () => mockRepository.campaignSectionsSectionIdDelete(
          sectionId: sections.first.id,
        ),
      ).thenThrow(Exception('Failed to delete section'));

      final result = await provider.deleteSection(sections.first.id);

      expect(result, false);
    });
  });
}
