import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/admin/providers/all_groups_list_provider.dart';
import 'package:myecl/admin/providers/is_expanded_list_provider.dart';
import 'package:myecl/admin/providers/module_visibility_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';

class ModulesExpansionPanel extends HookConsumerWidget {
  final List<ModuleVisibility> modules;
  final List<AccountType> accountTypes;

  const ModulesExpansionPanel({
    super.key,
    required this.modules,
    required this.accountTypes,
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
          .map(
            (moduleVisibility) => ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: isExpandedList[modules.indexOf(moduleVisibility)],
              headerBuilder: (context, isOpen) => Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  moduleVisibility.root,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              body: Column(
                children: [
                  Column(
                    children: [
                      const Divider(),
                      Text(
                        AdminTextConstants.accountTypes,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      ...accountTypes.map(
                        (accountType) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Text(
                                accountType.type,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              moduleVisibility.allowedAccountTypes
                                      .contains(accountType)
                                  ? GestureDetector(
                                      onTap: () async {
                                        final newModuleVisibility =
                                            moduleVisibility.copyWith(
                                          allowedAccountTypes: moduleVisibility
                                              .allowedAccountTypes
                                              .where(
                                                (type) => type != accountType,
                                              )
                                              .toList(),
                                        );
                                        await modulesNotifier
                                            .deleteAccountTypeAccessForModule(
                                          newModuleVisibility,
                                          accountType.type,
                                        );
                                      },
                                      child: HeroIcon(
                                        HeroIcons.eye,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        final newModuleVisibility =
                                            moduleVisibility.copyWith(
                                          allowedAccountTypes: moduleVisibility
                                                  .allowedAccountTypes +
                                              [accountType],
                                        );
                                        await modulesNotifier
                                            .addAccountTypeToModule(
                                          newModuleVisibility,
                                          accountType.type,
                                        );
                                      },
                                      child: HeroIcon(
                                        HeroIcons.eyeSlash,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    children: [
                      Text(
                        AdminTextConstants.groups,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ...groups.map(
                        (group) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Text(
                                group.name,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                                              moduleVisibility.allowedGroupIds
                                                  .where(
                                                    (groupId) =>
                                                        groupId != group.id,
                                                  )
                                                  .toList(),
                                        );
                                        await modulesNotifier
                                            .deleteGroupAccessForModule(
                                          newModuleVisibility,
                                          group.id,
                                        );
                                      },
                                      child: HeroIcon(
                                        HeroIcons.eye,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        final newModuleVisibility =
                                            moduleVisibility.copyWith(
                                          allowedGroupIds:
                                              moduleVisibility.allowedGroupIds +
                                                  [group.id],
                                        );
                                        await modulesNotifier.addGroupToModule(
                                          newModuleVisibility,
                                          group.id,
                                        );
                                      },
                                      child: HeroIcon(
                                        HeroIcons.eyeSlash,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
