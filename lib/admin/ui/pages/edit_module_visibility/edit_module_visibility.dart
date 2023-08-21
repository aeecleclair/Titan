import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/all_groups_list_provider.dart';
import 'package:myecl/admin/providers/module_visibility_list_provider.dart';
import 'package:myecl/admin/ui/admin.dart';

class EditModulesVisibilityPage extends HookConsumerWidget {
  const EditModulesVisibilityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesNotifier = ref.watch(moduleVisibilityListProvider.notifier);
    final modulesProvider = ref.watch(moduleVisibilityListProvider);
    final groups = ref.watch(allGroupList);
    return AdminTemplate(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: modulesProvider.when(
            data: (modules) => modules.isEmpty || groups.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ExpansionPanelList(
                    expansionCallback: (i, isOpen) {
                      modules[i].isExpanded = !modules[i].isExpanded;
                      modulesNotifier.setState(modules);
                    },
                    children: modules
                        .map((moduleVisibility) => ExpansionPanel(
                              canTapOnHeader: true,
                              isExpanded: moduleVisibility.isExpanded,
                              headerBuilder: (context, isOpen) => Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Spacer(),
                                            moduleVisibility.allowedGroupIds
                                                    .contains(group.id)
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      final newModuleVisibility =
                                                          moduleVisibility
                                                              .copyWith(
                                                                  allowedGroupIds:
                                                                      moduleVisibility
                                                                          .allowedGroupIds
                                                                          .where(
                                                                            (groupId) =>
                                                                                groupId !=
                                                                                group.id,
                                                                          )
                                                                          .toList());
                                                      await modulesNotifier
                                                          .deleteGroupAccessForModule(
                                                              newModuleVisibility,
                                                              group.id);
                                                    },
                                                    child: const HeroIcon(
                                                      HeroIcons.eye,
                                                      size: 40,
                                                    ))
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final newModuleVisibility =
                                                          moduleVisibility
                                                              .copyWith(
                                                        allowedGroupIds:
                                                            moduleVisibility
                                                                    .allowedGroupIds +
                                                                [group.id],
                                                      );
                                                      await modulesNotifier
                                                          .addGroupToModule(
                                                              newModuleVisibility,
                                                              group.id);
                                                    },
                                                    child: const HeroIcon(
                                                      HeroIcons.eyeSlash,
                                                      size: 40,
                                                    ))
                                          ]),
                                        ),
                                      )
                                      .toList()),
                            ))
                        .toList(),
                  ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ),
      ),
    );
  }
}
