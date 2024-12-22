import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/CMM/ui/components/button.dart';
import 'package:myecl/CMM/ui/my_cmm_tab/my_cmm_list.dart';

class MyCMMTab extends HookWidget {
  const MyCMMTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: MyCMMList(),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("salut");
          },
          child: const MyButton(
            text: "Ajouter un CMM",
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
