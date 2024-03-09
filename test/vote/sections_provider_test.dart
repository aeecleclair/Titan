import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/repositories/section_repository.dart';

class MockSectionRepository extends Mock implements SectionRepository {}

void main() {
  group('SectionNotifier', () {
    late SectionRepository sectionRepository;
    late SectionNotifier sectionNotifier;

    setUp(() {
      sectionRepository = MockSectionRepository();
      sectionNotifier = SectionNotifier(sectionRepository: sectionRepository);
    });

    test('loadSectionList should return AsyncValue<List<Section>>', () async {
      final sections = [Section.empty().copyWith(id: '1', name: 'Section 1')];
      when(() => sectionRepository.getSections())
          .thenAnswer((_) async => sections);

      final result = await sectionNotifier.loadSectionList();

      expect(
          result.when(
            data: (data) => data,
            loading: () => List<Section>.empty(),
            error: (_, __) => List<Section>.empty(),
          ),
          sections);
    });

    test('addSection should return true', () async {
      final section = Section.empty().copyWith(id: '1', name: 'Section 1');
      when(() => sectionRepository.createSection(section))
          .thenAnswer((_) async => section);
      sectionNotifier.state = AsyncValue.data([section]);

      final result = await sectionNotifier.addSection(section);

      expect(result, true);
    });

    test('updateSection should return true', () async {
      final section = Section.empty().copyWith(id: '1', name: 'Section 1');
      when(() => sectionRepository.updateSection(section))
          .thenAnswer((_) async => true);
      sectionNotifier.state = AsyncValue.data([section]);

      final result = await sectionNotifier.updateSection(section);

      expect(result, true);
    });

    test('deleteSection should return true', () async {
      final section = Section.empty().copyWith(id: '1', name: 'Section 1');
      when(() => sectionRepository.deleteSection(section.id))
          .thenAnswer((_) async => true);
      sectionNotifier.state = AsyncValue.data([section]);

      final result = await sectionNotifier.deleteSection(section);

      expect(result, true);
    });
  });
}
