import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/memberships/association_membership_list_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

final isMembershipAdminProvider = Provider<bool>((ref) {
  final me = ref.watch(userProvider);
  final memberships = ref.watch(allAssociationMembershipListProvider);
  return memberships.maybeWhen(
    data: (memberships) {
      return memberships.any(
        (membership) =>
            me.groups.any((group) => group.id == membership.managerGroupId),
      );
    },
    orElse: () => false,
  );
});
