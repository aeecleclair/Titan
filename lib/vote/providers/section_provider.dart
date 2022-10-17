import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/repositories/section_repository.dart';

class SectionNotifier extends ListNotifier<Section> {
  final SectionRepository _sectionRepository = SectionRepository();
  SectionNotifier({required String token}) : super(const AsyncValue.loading()) {
    _sectionRepository.setToken(token);
  }

  Future<AsyncValue<List<Section>>> loadSectionList() async {
    // return await loadList(_sectionRepository.getSections);
    state = AsyncValue.data([
      Section(
        id: '1',
        name: 'Section 1',
        description: 'Section 1',
        logoPath: '',
      ),
      Section(
        id: '2',
        name: 'Section 2',
        description: 'Section 2',
        logoPath: '',
      ),
      Section(
        id: '3',
        name: 'Section 3',
        description: 'Section 3',
        logoPath: '',
      ),
      Section(
        id: '4',
        name: 'Section 4',
        description: 'Section 4',
        logoPath: '',
      ),
      Section(
        id: '5',
        name: 'Section 5',
        description: 'Section 5',
        logoPath: '',
      ),
      Section(
        id: '6',
        name: 'Section 6',
        description: 'Section 6',
        logoPath: '',
      ),
      Section(
        id: '7',
        name: 'Section 7',
        description: 'Section 7',
        logoPath: '',
      ),
      Section(
        id: '8',
        name: 'Section 8',
        description: 'Section 8',
        logoPath: '',
      ),
    ]);
    return state;
  }

  Future<bool> addSection(Section section) async {
    return await add(
        (s) async => _sectionRepository.createSection(s), section);
  }

  Future<bool> updateSection(Section section) async {
    return await update(
        (s) async => _sectionRepository.updateSection(s),
        (sections, section) => sections
          ..[sections.indexWhere((s) => s.id == section.id)] = section,
        section);
  }

  Future<bool> deleteSection(Section section) async {
    return await delete(
        (id) async => _sectionRepository.deleteSection(id),
        (sections, section) => sections..removeWhere((s) => s.id == section.id),
        section.id,
        section);
  }
}

final sectionProvider = StateNotifierProvider<SectionNotifier, AsyncValue<List<Section>>>((ref) {
  final token = ref.watch(tokenProvider);
  SectionNotifier notifier = SectionNotifier(token: token);
  notifier.loadSectionList();
  return notifier;
});