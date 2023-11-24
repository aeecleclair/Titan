import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/admin/providers/all_groups_list_provider.dart';
import 'package:myecl/admin/providers/is_expanded_list_provider.dart';
import 'package:myecl/admin/providers/module_visibility_list_provider.dart';

class ModulesExpansionPanel extends HookConsumerWidget {
  final List<ModuleVisibility> modules;

  const ModulesExpansionPanel({
    super.key,
    required this.modules,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesNotifier = ref.watch(moduleVisibilityListProvider.notifier);
    final groups = ref.watch(allGroupList);
    final isExpandedList = ref.watch(isExpandedListProvider);
    final isExpandedListNotifier = ref.watch(isExpandedListProvider.notifier);
    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        isExpandedListNotifier.toggle(i);
      },
      children: modules
          .map((moduleVisibility) => ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: isExpandedList[modules.indexOf(moduleVisibility)],
                headerBuilder: (context, isOpen) => Container(
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
                                        final newModuleVisibility =
                                            moduleVisibility.copyWith(
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
                                                newModuleVisibility, group.id);
                                      },
                                      child: const HeroIcon(
                                        HeroIcons.eye,
                                        size: 40,
                                      ))
                                  : GestureDetector(
                                      onTap: () async {
                                        final newModuleVisibility =
                                            moduleVisibility.copyWith(
                                          allowedGroupIds:
                                              moduleVisibility.allowedGroupIds +
                                                  [group.id],
                                        );
                                        await modulesNotifier.addGroupToModule(
                                            newModuleVisibility, group.id);
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
    );
  }
}
