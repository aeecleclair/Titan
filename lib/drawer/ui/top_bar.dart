import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/tools/dialog.dart';
import 'package:myecl/drawer/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final auth = ref.watch(authTokenProvider.notifier);
    return Column(
      children: [
        Container(
          height: 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 25,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          user.nickname,
                          style: TextStyle(
                              color: Colors.grey.shade100,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      SizedBox(
                          width: 200,
                          child: Text(
                            "${user.firstname} ${user.name}",
                            style: TextStyle(
                              color: Colors.grey.shade100,
                              fontSize: 15,
                            ),
                          ))
                    ]),
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => BookingDialog(
                        descriptions: "Voulez-vous vous déconnecter ?",
                        title: "Déconnexion",
                        onYes: () {
                          auth.deleteToken();
                          displayDrawerToast(context, TypeMsg.msg, "Déconnexion");
                        }));
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: HeroIcon(
                      HeroIcons.arrowRightOnRectangle,
                      color: Colors.grey.shade100,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
