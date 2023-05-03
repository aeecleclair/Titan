import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/tombola/tools/constants.dart';


class ConfirmCreationDialog extends HookConsumerWidget {
  final SimpleGroup group;
  const ConfirmCreationDialog(
      {Key? key, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(backgroundColor: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 300,
            height: 450,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: TombolaColorConstants.gradient2,
                    blurRadius: 15,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: RadialGradient(colors: [
                  TombolaColorConstants.gradient1,
                  TombolaColorConstants.gradient2,
                ], center: Alignment.topLeft, radius: 1.5)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Voulez vous vraiment créer la tombola de ", style: TextStyle(color: Colors.white, fontSize: 30)),
                  Text(group.name, style: TextStyle(color: Colors.white, fontSize: 30))])));
  }
}
