import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final meNotifier = ref.watch(userProvider.notifier);
    final user = me.when(
      data: (user) => user,
      loading: () => meNotifier.lastLoadedUser,
      error: (e, s) => meNotifier.lastLoadedUser,
    );
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
                            user.firstname + " " + user.name,
                            style: TextStyle(
                              color: Colors.grey.shade100,
                              fontSize: 15,
                            ),
                          ))
                    ]),
              ],
            ),
          ],
        )
      ],
    );
  }
}
