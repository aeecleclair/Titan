import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/tools/constants.dart';

class LastInfos extends ConsumerWidget {
  const LastInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 500,
        margin: const EdgeInsets.all(30),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: const Text(HomeTextConstants.lastInfos,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ]));
  }
}
