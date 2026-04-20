import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/admin/tools/functions.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/super_admin/class/permissions.dart';
import 'package:titan/super_admin/providers/account_types_list_provider.dart';
import 'package:titan/super_admin/providers/permission_name_list_provider.dart';
import 'package:titan/super_admin/providers/permissions_list_provider.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/pages/permissions/permission_detail_modal.dart';
import 'package:titan/super_admin/ui/pages/permissions/permission_tile.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
import 'package:tuple/tuple.dart';

class PermissionsPage extends HookConsumerWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final permissionsNames = ref.watch(permissionsNamesListProvider);
    final permissions = ref.watch(permissionsProvider);
    final groups = ref.watch(allGroupListProvider);
    final accountTypes = ref.watch(allAccountTypesListProvider);
    final mappedPermissions = ref.watch(mappedPermissionsProvider);
    final moduleGrouped = ref.watch(moduleGroupedPermissionsProvider);
    final scrollController = useScrollController();
    final query = useState('');

    return SuperAdminTemplate(
      child: ScrollToHideNavbar(
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Text(
              l10n.adminModifyPermissions,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
            const SizedBox(height: 16),
            CustomSearchBar(
              hintText: l10n.adminModifyPermissions,
              onSearch: (value) => query.value = value.trim().toLowerCase(),
            ),
            const SizedBox(height: 16),
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
                  ) {
                    final filtered = _filterModules(moduleGrouped, query.value);
                    if (filtered.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Center(
                          child: Text(
                            l10n.adminError,
                            style: const TextStyle(
                              color: ColorConstants.secondary,
                            ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ...filtered.map((entry) {
                          return _ModuleSection(
                            moduleName: entry.key,
                            permissionNames: entry.value,
                            mappedPermissions: mappedPermissions,
                            accountTypes: accountTypes,
                            groups: groups,
                          );
                        }),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }

  List<MapEntry<String, List<String>>> _filterModules(
    Map<String, List<String>> grouped,
    String query,
  ) {
    if (query.isEmpty) return grouped.entries.toList();
    final result = <MapEntry<String, List<String>>>[];
    for (final entry in grouped.entries) {
      final moduleMatches = entry.key.toLowerCase().contains(query);
      final matchingPermissions = entry.value
          .where((p) => p.toLowerCase().contains(query))
          .toList();
      if (moduleMatches) {
        result.add(MapEntry(entry.key, entry.value));
      } else if (matchingPermissions.isNotEmpty) {
        result.add(MapEntry(entry.key, matchingPermissions));
      }
    }
    return result;
  }
}

class _ModuleSection extends HookConsumerWidget {
  final String moduleName;
  final List<String> permissionNames;
  final Map<String, CorePermission> mappedPermissions;
  final List<AccountType> accountTypes;
  final List<SimpleGroup> groups;

  const _ModuleSection({
    required this.moduleName,
    required this.permissionNames,
    required this.mappedPermissions,
    required this.accountTypes,
    required this.groups,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8, bottom: 6),
            child: Text(
              moduleName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ColorConstants.gradient1,
              ),
            ),
          ),
          ...permissionNames.map((shortName) {
            final fullName = '$moduleName.$shortName';
            final permission =
                mappedPermissions[fullName] ?? mappedPermissions[shortName];
            final authorizedAccountTypes =
                permission?.authorizedAccountTypes.length ?? 0;
            final authorizedGroups = permission?.authorizedGroupIds.length ?? 0;
            return PermissionTile(
              title: capitalizePermissionName(shortName),
              authorizedAccountTypes: authorizedAccountTypes,
              totalAccountTypes: accountTypes.length,
              authorizedGroups: authorizedGroups,
              totalGroups: groups.length,
              onTap: () {
                showCustomBottomModal(
                  context: context,
                  ref: ref,
                  modal: PermissionDetailModal(
                    permissionName: fullName,
                    accountTypes: accountTypes,
                    groups: groups,
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
