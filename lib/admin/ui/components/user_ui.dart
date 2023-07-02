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
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ColorConstants.background2, Colors.black],
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
                child: const HeroIcon(
                  HeroIcons.trash,
                  size: 20,
                  color: Colors.white,
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
