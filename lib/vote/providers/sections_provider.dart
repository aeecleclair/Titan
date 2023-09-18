import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/repositories/section_repository.dart';

class SectionNotifier extends ListNotifier<Section> {
  final SectionRepository _sectionRepository = SectionRepository();
  SectionNotifier({required String token}) : super(const AsyncValue.loading()) {
    _sectionRepository.setToken(token);
  }

  Future<AsyncValue<List<Section>>> loadSectionList() async {
    return await loadList(_sectionRepository.getSections);
  }

  Future<bool> addSection(Section section) async {
    return await add(_sectionRepository.createSection, section);
  }

  Future<bool> updateSection(Section section) async {
    return await update(
        _sectionRepository.updateSection,
        (sections, section) => sections
          ..[sections.indexWhere((s) => s.id == section.id)] = section,
        section);
  }

  Future<bool> deleteSection(Section section) async {
    return await delete(
        _sectionRepository.deleteSection,
        (sections, section) => sections..removeWhere((s) => s.id == section.id),
        section.id,
        section);
  }
}

final sectionsProvider =
    StateNotifierProvider<SectionNotifier, AsyncValue<List<Section>>>((ref) {
  final token = ref.watch(tokenProvider);
  SectionNotifier notifier = SectionNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadSectionList();
  });
  return notifier;
});

final sectionList = Provider<List<Section>>((ref) {
  final sections = ref.watch(sectionsProvider);
  return sections.maybeWhen(data: (section) {
    return section;
  }, orElse: () {
    return [];
  });
});

final sectionProvider = Provider<Section>((ref) {
  final sections = ref.watch(sectionList);
  final sectionId = ref.watch(sectionIdProvider);
  return sections.isEmpty
      ? Section.empty()
      : sections.where((element) => element.id == sectionId).first;
});
