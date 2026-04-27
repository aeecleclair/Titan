import 'package:flutter/material.dart';
import 'package:titan/centralisation/class/section.dart';
import 'package:titan/centralisation/ui/pages/module_card.dart';

class SectionList extends StatelessWidget {
  final Section section;
  const SectionList({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              section.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            itemCount: section.moduleList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) =>
                ModuleCard(module: section.moduleList[index]),
          ),
        ],
      ),
    );
  }
}
