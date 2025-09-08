import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/providers/section_id_provider.dart';
import 'package:titan/vote/repositories/section_repository.dart';

class SectionNotifier extends ListNotifier<Section> {
  final SectionRepository sectionRepository;
  SectionNotifier({required this.sectionRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Section>>> loadSectionList() async {
    return await loadList(sectionRepository.getSections);
  }

  Future<bool> addSection(Section section) async {
    return await add(sectionRepository.createSection, section);
  }

  Future<bool> updateSection(Section section) async {
    return await update(
      sectionRepository.updateSection,
      (sections, section) =>
          sections..[sections.indexWhere((s) => s.id == section.id)] = section,
      section,
    );
  }

  Future<bool> deleteSection(Section section) async {
    return await delete(
      sectionRepository.deleteSection,
      (sections, section) => sections..removeWhere((s) => s.id == section.id),
      section.id,
      section,
    );
  }
}

final sectionsProvider =
    StateNotifierProvider<SectionNotifier, AsyncValue<List<Section>>>((ref) {
      final sectionRepository = ref.watch(sectionRepositoryProvider);
      SectionNotifier notifier = SectionNotifier(
        sectionRepository: sectionRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadSectionList();
      });
      return notifier;
    });

final sectionList = Provider<List<Section>>((ref) {
  final sections = ref.watch(sectionsProvider);
  return sections.maybeWhen(
    data: (section) {
      return section;
    },
    orElse: () {
      return [];
    },
  );
});

final sectionProvider = Provider<Section>((ref) {
  final sections = ref.watch(sectionList);
  final sectionId = ref.watch(sectionIdProvider);
  return sections.isEmpty
      ? Section.empty()
      : sections.where((element) => element.id == sectionId).first;
});
