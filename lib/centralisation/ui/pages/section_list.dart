import 'package:flutter/material.dart';
import 'package:titan/centralisation/class/section.dart';
import 'package:titan/centralisation/ui/pages/module_card.dart';

class SectionList extends StatelessWidget {
  final Section section;
  const SectionList({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.name,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: section.moduleList
                .map((module) => ModuleCard(module: module))
                .toList(),
          ),
        ],
      ),
    );
  }
}
