import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';

class SectionNotifier extends ListNotifier2<SectionComplete> {
  final Openapi sectionRepository;
  SectionNotifier({required this.sectionRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<SectionComplete>>> loadSectionList() async {
    return await loadList(sectionRepository.campaignSectionsGet);
  }

  Future<bool> addSection(SectionBase section) async {
    return await add(() => sectionRepository.campaignSectionsPost(body: section), section);
  }

  Future<bool> deleteSection(SectionComplete section) async {
    return await delete(
      () => sectionRepository.campaignSectionsSectionIdDelete(sectionId: section.id),
      (sections, section) => sections..removeWhere((s) => s.id == section.id),
      section,
    );
  }
}

final sectionsProvider =
    StateNotifierProvider<SectionNotifier, AsyncValue<List<SectionComplete>>>((ref) {
  final sectionRepository = ref.watch(repositoryProvider);
  SectionNotifier notifier =
      SectionNotifier(sectionRepository: sectionRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadSectionList();
  });
  return notifier;
});

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
      ? SectionComplete.fromJson({})
      : sections.where((element) => element.id == sectionId).first;
});
