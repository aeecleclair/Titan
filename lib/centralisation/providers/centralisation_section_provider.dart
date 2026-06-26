import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/centralisation/class/module.dart';
import 'package:titan/centralisation/class/section.dart';
import 'package:titan/centralisation/repositories/section_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class SectionNotifier extends ListNotifier<Section> {
  SectionRepository sectionRepository = SectionRepository();

  @override
  AsyncValue<List<Section>> build() {
    return const AsyncValue.loading();
  }

  late List<Section> allSections = [];
  late List<Module> allModules = [];
  late List<Module> modulesLiked = [];

  Future initState() async {
    allSections = await sectionRepository.getSectionList();
    allModules = allSections.expand((element) => element.moduleList).toList();
    state = AsyncValue.data(allSections);
  }
}

final sectionProvider =
    NotifierProvider<SectionNotifier, AsyncValue<List<Section>>>(
      SectionNotifier.new,
    );
