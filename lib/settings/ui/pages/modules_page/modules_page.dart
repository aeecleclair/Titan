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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ReorderableListView(
        physics: BouncingScrollPhysics(),
        proxyDecorator: (child, index, animation) {
          return Material(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          modulesNotifier.reorderModules(oldIndex, newIndex);
        },
        children: modulesNotifier.allModules.map((module) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            key: Key(module.page.toString()),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  HeroIcon(
                    module.icon,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
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
                  const Spacer(),
                  // Switch(
                  //   value: modules.contains(module),
                  //   activeColor: Colors.grey.shade700,
                  //   onChanged: (bool value) {
                  //     modulesNotifier.toggleModule(module);
                  //   },
                  // ),
                  Checkbox(
                    value: modules.contains(module),
                    activeColor: Colors.grey.shade700,
                    onChanged: (bool? value) {
                      modulesNotifier.toggleModule(module);
                    },
                  ),
                  const HeroIcon(
                    HeroIcons.chevronUpDown,
                    size: 30,
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
