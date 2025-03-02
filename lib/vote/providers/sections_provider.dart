import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';

class SectionNotifier extends ListNotifierAPI<SectionComplete> {
  final Openapi sectionRepository;
  SectionNotifier({required this.sectionRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<SectionComplete>>> loadSectionList() async {
    return await loadList(sectionRepository.campaignSectionsGet);
  }

  Future<bool> addSection(SectionBase section) async {
    return await add(
        () => sectionRepository.campaignSectionsPost(body: section), section);
  }

  Future<bool> deleteSection(String sectionId) async {
    return await delete(
      () => sectionRepository.campaignSectionsSectionIdDelete(
          sectionId: sectionId),
      (s) => s.id,
      sectionId,
    );
  }
}

final sectionsProvider =
    StateNotifierProvider<SectionNotifier, AsyncValue<List<SectionComplete>>>(
        (ref) {
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
