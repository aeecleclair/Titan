import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/module_list_provider.dart';

class ModulesPage extends HookConsumerWidget {
  const ModulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(modulesProvider);
    final modulesNotifier = ref.watch(modulesProvider.notifier);
    return ListView.builder(
        itemCount: modulesNotifier.allModules.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              modulesNotifier.allModules[index].name,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            trailing: Switch(
              value: modules.contains(modulesNotifier.allModules[index]),
              onChanged: (bool value) {
                modulesNotifier.toggleModule(modulesNotifier.allModules[index]);
              },
            ),
          );
        });
  }
}
