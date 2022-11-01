import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/selected_section_provider.dart';

class SectionTitle extends HookConsumerWidget {
  final List<Section> sectionList;
  const SectionTitle({super.key, required this.sectionList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSection = ref.watch(selectedsectionsProvider);
    return Container(
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: Text(sectionList[selectedSection].name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)),
    );
  }
}
