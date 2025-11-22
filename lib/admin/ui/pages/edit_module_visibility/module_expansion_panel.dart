import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/tools/function.dart';

class ModulePermissionsExpansionPanel extends HookConsumerWidget {
  const ModulePermissionsExpansionPanel({
    super.key,
    required this.permissionNames,
    required this.accountTypes,
    required this.groups,
  });
  final List<String> permissionNames;
  final List<AccountType> accountTypes;
  final List<SimpleGroup> groups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionExpanded = useState<List<bool>>(
      List.generate(permissionNames.length, (index) => false),
    );
    final permissions = ref.watch(permissionsProvider);

    final permissionsProviderNotifier = ref.read(
      allPermissionsProvider.notifier,
    );

    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        permissionExpanded.value = permissionExpanded.value..[i] = isOpen;
      },
      children: permissionNames
          .map(
            (permissionName) => ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: permissionExpanded
                  .value[permissionNames.indexOf(permissionName)],
              headerBuilder: (context, isOpen) => ListTile(
                title: Text(
                  capitalizePermissionName(permissionName),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Column(
                children: [
                  const Text(
                    AdminTextConstants.accountTypes,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  ...accountTypes.map((accountType) {
                    final permission = AccountTypePermission(
                      permissionName: permissionName,
                      accountType: accountType.type,
                    );
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            accountType.type,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          permissions[permissionName]!.authorizedAccountTypes
                                  .contains(accountType.type)
                              ? GestureDetector(
                                  onTap: () async {
                                    await permissionsProviderNotifier
                                        .deleteAccountTypePermission(
                                          permission,
                                        );
                                  },
                                  child: const HeroIcon(
                                    HeroIcons.eye,
                                    size: 40,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await permissionsProviderNotifier
                                        .addAccountTypePermission(permission);
                                  },
                                  child: const HeroIcon(
                                    HeroIcons.eyeSlash,
                                    size: 40,
                                  ),
                                ),
                        ],
                      ),
                    );
                  }),
                  const Divider(),
                  const Text(
                    AdminTextConstants.groups,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  ...groups.map((group) {
                    final moduleVisibility = GroupPermission(
                      permissionName: permissionName,
                      groupId: group.id,
                    );
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            group.name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          permissions[permissionName]!.authorizedGroups
                                  .contains(group.id)
                              ? GestureDetector(
                                  onTap: () async {
                                    await permissionsProviderNotifier
                                        .deleteGroupPermission(
                                          moduleVisibility,
                                        );
                                  },
                                  child: const HeroIcon(
                                    HeroIcons.eye,
                                    size: 40,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await permissionsProviderNotifier
                                        .addGroupPermission(moduleVisibility);
                                  },
                                  child: const HeroIcon(
                                    HeroIcons.eyeSlash,
                                    size: 40,
                                  ),
                                ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
