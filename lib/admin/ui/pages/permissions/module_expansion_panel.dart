import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_list_provider.dart';
import 'package:titan/admin/ui/pages/permissions/permission_expansion_panel.dart';

class ModuleExpansionPanel extends HookConsumerWidget {
  final List<String> permissionsNames;
  final List<SimpleGroup> groups;
  final List<AccountType> accountTypes;

  const ModuleExpansionPanel({
    super.key,
    required this.permissionsNames,
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
      children: modulesPermissionNames.keys.map((module) {
        final index = modulesPermissionNames.keys.toList().indexOf(module);
        return ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isExpanded.value[index],
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
          body: isExpanded.value[index]
              ? PermissionsExpansionPanel(
                  permissionNames: modulesPermissionNames[module]!,
                  accountTypes: accountTypes,
                  groups: groups,
                )
              : const SizedBox.shrink(),
        );
      }).toList(),
    );
  }
}
