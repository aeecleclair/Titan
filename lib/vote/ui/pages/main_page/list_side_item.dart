import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/selected_pretendance_index_provider.dart';
import 'package:myecl/vote/providers/selected_section_provider.dart';
import 'package:myecl/vote/ui/pages/main_page/side_item.dart';

class ListSideItem extends HookConsumerWidget {
  final List<Section> sectionList;
  final AnimationController animation;
  const ListSideItem({super.key, required this.sectionList, required this.animation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSection = ref.watch(selectedSectionProvider);
    final selectedSectionNotifier = ref.watch(selectedSectionProvider.notifier);
    final selectedPretendanceIndexNotifier =
        ref.watch(selectedPretendanceIndexProvider.notifier);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: sectionList.map((e) {
          final index = sectionList.indexOf(e);
          return SideItem(
            section: e,
            isSelected: index == selectedSection,
            onTap: () {
              selectedSectionNotifier.setSelectedSection(index);
              animation.forward(from: 0);
              selectedPretendanceIndexNotifier.setSelectedPretendance(-1);
            },
          );
        }).toList(),
      ),
    );
  }
}
