import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SectionNotifier extends ListNotifier<Section> {
  SectionRepository sectionRepository = SectionRepository();
  SectionNotifier() : super(const AsyncValue.loading());

  late List<Section> allSections = [];
  late List<Module> allModules = [];
  late List<Module> modulesLiked = [];

  Future<void> initState() async {
    allSections = await sectionRepository.getSectionList();
    allModules = allSections.expand((element) => element.moduleList).toList();
    state = AsyncValue.data(allSections);
  }
}

final sectionProvider =
    StateNotifierProvider<SectionNotifier, AsyncValue<List<Section>>>((ref) {
  SectionNotifier notifier = SectionNotifier();
  tokenExpireWrapperAuth(ref, () async {
    await notifier.initState();
  });
  return notifier;
});
