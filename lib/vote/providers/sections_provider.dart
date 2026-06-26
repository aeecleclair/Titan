import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/vote/providers/section_id_provider.dart';

class SectionNotifier extends ListNotifierAPI<SectionComplete> {
  Openapi get sectionRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<SectionComplete>> build() {
    loadSectionList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<SectionComplete>>> loadSectionList() async {
    return await loadList(sectionRepository.campaignSectionsGet);
  }

  Future<bool> addSection(SectionBase section) async {
    return await add(
      () => sectionRepository.campaignSectionsPost(body: section),
      section,
    );
  }

  Future<bool> deleteSection(SectionComplete section) async {
    return await delete(
      () => sectionRepository.campaignSectionsSectionIdDelete(
        sectionId: section.id,
      ),
      (section) => section.id,
      section.id,
    );
  }
}

final sectionsProvider =
    NotifierProvider<SectionNotifier, AsyncValue<List<SectionComplete>>>(
      SectionNotifier.new,
    );

final sectionList = Provider<List<SectionComplete>>((ref) {
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

final sectionProvider = Provider<SectionComplete>((ref) {
  final sections = ref.watch(sectionList);
  final sectionId = ref.watch(sectionIdProvider);
  return sections.isEmpty
      ? SectionComplete.empty()
      : sections.where((element) => element.id == sectionId).first;
});
