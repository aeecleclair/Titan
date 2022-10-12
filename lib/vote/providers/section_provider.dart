import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/vote/class/section.dart';
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