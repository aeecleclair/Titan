import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/meme/router.dart';
import 'package:myecl/meme/ui/components/button.dart';
import 'package:myecl/meme/ui/my_meme_tab/my_meme_list.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MyMemeTab extends HookWidget {
  const MyMemeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MyMemeList(),
          //child: Container(),
        ),
        GestureDetector(
          onTap: () {
            QR.to(MemeRouter.root + MemeRouter.add);
          },
          child: const MyButton(
            text: "Ajouter un Meme",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
