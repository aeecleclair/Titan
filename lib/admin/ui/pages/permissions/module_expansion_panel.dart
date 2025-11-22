import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_provider.dart';
import 'package:titan/admin/ui/pages/permissions/permission_expansion_panel.dart';

class ModuleExpansionPanel extends HookConsumerWidget {
  final List<String> permissionsNames;
  final AllPermissions permissions;
  final List<SimpleGroup> groups;
  final List<AccountType> accountTypes;

  const ModuleExpansionPanel({
    super.key,
    required this.permissionsNames,
    required this.permissions,
    required this.groups,
    required this.accountTypes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState<List<bool>>(
      List.generate(permissionsNames.length, (index) => false),
    );
    final modulesPermissionNames = ref.watch(moduleGroupedPermissionsProvider);

    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        isExpanded.value[i] = isOpen;
        isExpanded.value = List.from(isExpanded.value);
      },
      children: modulesPermissionNames.keys
          .map(
            (module) => ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: isExpanded
                  .value[modulesPermissionNames.keys.toList().indexOf(module)],
              headerBuilder: (context, isOpen) => Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  module,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              body: PermissionsExpansionPanel(
                permissionNames: modulesPermissionNames[module]!,
                accountTypes: accountTypes,
                groups: groups,
              ),
            ),
          )
          .toList(),
    );
  }
}
