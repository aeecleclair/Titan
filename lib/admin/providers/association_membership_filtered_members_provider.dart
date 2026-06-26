import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/research_filter_provider.dart';
import 'package:diacritic/diacritic.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/user/extensions/core_user_simple.dart';

final associationMembershipFilteredListProvider =
    Provider<List<UserMembershipComplete>>((ref) {
      final userAssociationMemberships = ref.watch(
        associationMembershipMembersProvider,
      );
      final searchFilter = ref.watch(filterProvider);
      return userAssociationMemberships.maybeWhen(
        data: (userAssociationMemberships) {
          return userAssociationMemberships
              .where(
                (associationMembership) => removeDiacritics(
                  associationMembership.user.getName().toLowerCase(),
                ).contains(removeDiacritics(searchFilter.toLowerCase())),
              )
              .toList();
        },
        orElse: () => [],
      );
    });
