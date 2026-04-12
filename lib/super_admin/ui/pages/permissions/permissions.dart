import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/super_admin/providers/account_types_list_provider.dart';
import 'package:titan/super_admin/providers/permission_name_list_provider.dart';
import 'package:titan/super_admin/providers/permissions_list_provider.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/pages/permissions/module_expansion_panel.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:tuple/tuple.dart';

class PermissionsPage extends HookConsumerWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionsNames = ref.watch(permissionsNamesListProvider);
    final permissions = ref.watch(permissionsProvider);
    final groups = ref.watch(allGroupListProvider);
    final accountTypes = ref.watch(allAccountTypesListProvider);

    final localizeWithContext = AppLocalizations.of(context)!;

    return SuperAdminTemplate(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localizeWithContext.adminModifyPermissions,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Async4Children(
                      values: Tuple4(
                        permissionsNames,
                        permissions,
                        groups,
                        accountTypes,
                      ),
                      builder:
                          (
                            context,
                            permissionsNames,
                            permissions,
                            groups,
                            accountTypes,
                          ) => ModuleExpansionPanel(
                            permissionsNames: permissionsNames,
                            groups: groups,
                            accountTypes: accountTypes,
                          ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
