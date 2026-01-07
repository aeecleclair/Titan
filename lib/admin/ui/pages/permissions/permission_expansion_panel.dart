import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_list_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/tools/function.dart';
import 'package:titan/admin/ui/pages/permissions/permission_row.dart';

class PermissionsExpansionPanel extends HookConsumerWidget {
  const PermissionsExpansionPanel({
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
    final permissions = ref.watch(mappedPermissionsProvider);

    final permissionsProviderNotifier = ref.read(permissionsProvider.notifier);

    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        permissionExpanded.value[i] = isOpen;
        permissionExpanded.value = List.from(permissionExpanded.value);
      },
      children: permissionNames.map((permissionName) {
        final index = permissionNames.indexOf(permissionName);
        return ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: permissionExpanded.value[index],
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
          body: permissionExpanded.value[index]
              ? Column(
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
                      final isAuthorized = permissions[permissionName]!
                          .authorizedAccountTypes
                          .contains(accountType.type);
                      return PermissionRow(
                        label: accountType.type,
                        isAuthorized: isAuthorized,
                        onUnauthorize: () async {
                          await permissionsProviderNotifier
                              .deleteAccountTypePermission(permission);
                        },
                        onAuthorize: () async {
                          await permissionsProviderNotifier
                              .addAccountTypePermission(permission);
                        },
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
                      final permission = GroupPermission(
                        permissionName: permissionName,
                        groupId: group.id,
                      );
                      final isAuthorized = permissions[permissionName]!
                          .authorizedGroupIds
                          .contains(group.id);
                      return PermissionRow(
                        label: group.name,
                        isAuthorized: isAuthorized,
                        onUnauthorize: () async {
                          await permissionsProviderNotifier
                              .deleteGroupPermission(permission);
                        },
                        onAuthorize: () async {
                          await permissionsProviderNotifier.addGroupPermission(
                            permission,
                          );
                        },
                      );
                    }),
                  ],
                )
              : const SizedBox.shrink(),
        );
      }).toList(),
    );
  }
}
