import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/user_association_membership_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult({super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final membershipNotifier = ref.watch(
      userAssociationMembershipProvider.notifier,
    );
    final membership = ref.watch(userAssociationMembershipProvider);

    return AsyncChild(
      value: users,
      builder: (context, usersData) {
        return Column(
          children: usersData
              .map(
                (user) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          user.getName(),
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          membershipNotifier.setUserAssociationMembership(
                            membership.copyWith(user: user, userId: user.id),
                          );
                          usersNotifier.clear();
                          Navigator.of(context).pop();
                        },
                        child: const HeroIcon(HeroIcons.plus),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
