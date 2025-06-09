import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/admin/class/user_association_membership.dart';
import 'package:myemapp/admin/providers/association_membership_members_list_provider.dart';
import 'package:myemapp/admin/providers/research_filter_provider.dart';
import 'package:diacritic/diacritic.dart';

final associationMembershipFilteredListProvider =
    Provider<List<UserAssociationMembership>>((ref) {
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
