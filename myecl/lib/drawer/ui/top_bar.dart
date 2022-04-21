import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(user("a4237b44-e0a6-4e0c-9cfd-7a418752dafc"));
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
                          me.nickname,
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
                            me.firstname + " " + me.name,
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
