import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

final sectionProvider = Provider<Section>((ref) {
  final sectionId = ref.watch(sectionIdProvider);
  final sectionList = ref.watch(sectionsProvider);
  return sectionList.when(
    data: (sectionList) =>
        sectionList.firstWhere((loaner) => loaner.id == sectionId),
    error: (error, stackTrace) => Section.empty(),
    loading: () => Section.empty(),
  );
});
