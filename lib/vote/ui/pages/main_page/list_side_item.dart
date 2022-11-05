import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_pretendance_index_provider.dart';
import 'package:myecl/vote/ui/pages/main_page/side_item.dart';

class ListSideItem extends HookConsumerWidget {
  final List<Section> sectionList;
  final AnimationController animation;
  const ListSideItem(
      {super.key, required this.sectionList, required this.animation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final selectedPretendanceIndexNotifier =
        ref.watch(selectedPretendanceIndexProvider.notifier);
    final section = ref.watch(sectionProvider);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);
    final sectionPretendanceNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: sectionList.map((e) {
          final index = sectionList.indexOf(e);
          return SideItem(
            section: e,
            isSelected: e.id == section.id,
            onTap: () async {
              animation.forward(from: 0);
              selectedPretendanceIndexNotifier.setSelectedPretendance(-1);
              sectionIdNotifier.setId(e.id);
              pretendanceNotifier
                  .loadPretendanceListBySection(e.id)
                  .then((value) {
                pretendanceNotifier.copy().then((value) {
                  sectionPretendanceNotifier.setTData(e, value);
                });
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
