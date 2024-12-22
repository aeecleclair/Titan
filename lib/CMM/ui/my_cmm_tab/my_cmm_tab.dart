import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/CMM/router.dart';
import 'package:myecl/CMM/ui/components/button.dart';
import 'package:myecl/CMM/ui/my_cmm_tab/my_cmm_list.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MyCMMTab extends HookWidget {
  const MyCMMTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: SingleChildScrollView(
            child: MyCMMList(),
          ),
        ),
        GestureDetector(
          onTap: () {
            QR.to(CMMRouter.root + CMMRouter.add);
          },
          child: const MyButton(
            text: "Ajouter un CMM",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
