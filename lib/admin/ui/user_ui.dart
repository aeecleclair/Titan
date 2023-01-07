import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/user/class/list_users.dart';

class UserUi extends HookConsumerWidget {
  final SimpleUser user;
  final Function onDelete;

  const UserUi({Key? key, required this.user, required this.onDelete})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                user.getName(),
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.tertiary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                      Theme.of(context).colorScheme.tertiary
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: ColorConstants.background2.withOpacity(0.4),
                        offset: const Offset(2, 3),
                        blurRadius: 5)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: HeroIcon(
                  HeroIcons.trash,
                  size: 20,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              onTap: () {
                onDelete();
              },
            ),
          ],
        ));
  }
}
