import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/tools/functions.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/super_admin/class/permissions.dart';
import 'package:titan/super_admin/providers/permissions_list_provider.dart';
import 'package:titan/super_admin/ui/pages/permissions/permission_row.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

class PermissionDetailModal extends HookConsumerWidget {
  final String permissionName;
  final List<AccountType> accountTypes;
  final List<SimpleGroup> groups;

  const PermissionDetailModal({
    super.key,
    required this.permissionName,
    required this.accountTypes,
    required this.groups,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final modalMaxHeight = screenHeight * 0.85;
    final bodyHeight = (modalMaxHeight - 190)
        .clamp(220.0, screenHeight * 0.65)
        .toDouble();
    final actionPermissionName = permissionName.contains('.')
        ? permissionName.split('.').last
        : permissionName;
    final permissions = ref.watch(mappedPermissionsProvider);
    final permissionsNotifier = ref.read(permissionsProvider.notifier);
    final permission =
        permissions[permissionName] ?? permissions[actionPermissionName];

    Future<void> runPermissionUpdate(Future<bool> Function() action) async {
      final success = await action();
      if (!success && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.adminError)));
      }
    }

    final authorizedAccountTypes = permission?.authorizedAccountTypes ?? [];
    final authorizedGroupIds = permission?.authorizedGroupIds ?? [];

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: modalMaxHeight),
      child: BottomModalTemplate(
        title: capitalizePermissionName(permissionName),
        child: SizedBox(
          height: bodyHeight,
          child: Scrollbar(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SectionHeader(title: l10n.adminAccountTypes),
                  ...accountTypes.map((accountType) {
                    final isAuthorized = authorizedAccountTypes.contains(
                      accountType.type,
                    );
                    final model = AccountTypePermission(
                      permissionName: actionPermissionName,
                      accountType: accountType.type,
                    );
                    return PermissionRow(
                      label: accountType.type,
                      isAuthorized: isAuthorized,
                      onAuthorize: () async {
                        await runPermissionUpdate(
                          () => permissionsNotifier.addAccountTypePermission(
                            model,
                          ),
                        );
                      },
                      onUnauthorize: () async {
                        await runPermissionUpdate(
                          () => permissionsNotifier.deleteAccountTypePermission(
                            model,
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  _SectionHeader(title: l10n.adminGroups),
                  ...groups.map((group) {
                    final isAuthorized = authorizedGroupIds.contains(group.id);
                    final model = GroupPermission(
                      permissionName: actionPermissionName,
                      groupId: group.id,
                    );
                    return PermissionRow(
                      label: group.name,
                      isAuthorized: isAuthorized,
                      onAuthorize: () async {
                        await runPermissionUpdate(
                          () => permissionsNotifier.addGroupPermission(model),
                        );
                      },
                      onUnauthorize: () async {
                        await runPermissionUpdate(
                          () =>
                              permissionsNotifier.deleteGroupPermission(model),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ColorConstants.tertiary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(height: 1, color: ColorConstants.onBackground),
          ),
        ],
      ),
    );
  }
}
