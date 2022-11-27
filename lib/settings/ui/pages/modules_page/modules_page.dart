import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/module_list_provider.dart';

class ModulesPage extends HookConsumerWidget {
  const ModulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(modulesProvider);
    final modulesNotifier = ref.watch(modulesProvider.notifier);
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        modulesNotifier.reorderModules(oldIndex, newIndex);
      },
      children: modulesNotifier.allModules.map((module) {
        return ListTile(
          key: Key(module.page.toString()),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                module.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              Switch(
                value: modules.contains(module),
                onChanged: (bool value) {
                  modulesNotifier.toggleModule(module);
                },
              ),
            ],
          ),
          trailing: const HeroIcon(HeroIcons.chevronUpDown),
        );
      }).toList(),
    );
  }
}
