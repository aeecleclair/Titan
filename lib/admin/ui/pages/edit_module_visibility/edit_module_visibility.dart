import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/all_groups_list_provider.dart';
import 'package:myecl/admin/providers/all_module_visibility_list_provider.dart';
import 'package:myecl/admin/providers/module_visibility_list_provider.dart';
import 'package:myecl/admin/ui/admin.dart';

class EditModulesVisibilityPage extends HookConsumerWidget {
  const EditModulesVisibilityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesNotifier = ref.watch(moduleVisibilityListProvider.notifier);

    final modules = ref.watch(allModuleVisibilityList);
    final groups = ref.watch(allGroupList);

    return AdminTemplate(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: modules.isEmpty || groups.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ExpansionPanelList(
                    expansionCallback: (i, isExpanded) {
                      modules[i].isExpanded = !modules[i].isExpanded;
                    },
                    children: modules.map((moduleVisibility) {
                      return ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: moduleVisibility.isExpanded,
                        headerBuilder: (context, isExpanded) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            moduleVisibility.root,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        body: Column(
                            children: groups
                                .map(
                                  (group) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Row(children: [
                                      Text(
                                        group.name,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      moduleVisibility.allowedGroupIds
                                              .contains(group.id)
                                          ? GestureDetector(
                                              onTap: () async {
                                                await modulesNotifier
                                                    .deleteGroupAccessForModule(
                                                        moduleVisibility.root,
                                                        group.id);
                                                await modulesNotifier
                                                    .loadModuleVisibility();
                                              },
                                              child: const HeroIcon(
                                                HeroIcons.eye,
                                                size: 40,
                                              ))
                                          : GestureDetector(
                                              onTap: () async {
                                                await modulesNotifier
                                                    .addGroupToModule(
                                                        moduleVisibility.root,
                                                        group.id);
                                                await modulesNotifier
                                                    .loadModuleVisibility();
                                              },
                                              child: const HeroIcon(
                                                HeroIcons.eyeSlash,
                                                size: 40,
                                              ))
                                    ]),
                                  ),
                                )
                                .toList()),
                      );
                    }).toList(),
                  )),
      ),
    );
  }
}
