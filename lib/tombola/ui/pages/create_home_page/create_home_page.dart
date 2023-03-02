import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';

import '../../add_button.dart';
import '../../card_tombolas.dart';

class CreateHomePage extends HookConsumerWidget {
  const CreateHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Stack(children: [
        ListView(physics: const BouncingScrollPhysics(), children: [
          Text(TombolaTextConstants.modifTombola),
          Center(
            child: Text(
              TombolaTextConstants.actualTombolas,
              style: TextStyle(fontSize: 30),
            ),
          ),
          TombolaWidget(
              name: "Tombola Soli Sida",
              color: Color.fromARGB(255, 126, 149, 254)),
          TombolaWidget(
              name: "Tombola 4", color: Color.fromARGB(255, 41, 6, 216)),
          TombolaWidget(
              name: "Tombola 4", color: Color.fromARGB(255, 48, 63, 228)),
          TombolaWidget(
              name: "Tombola 4", color: Color.fromARGB(255, 23, 41, 199)),
          TombolaWidget(
              name: "Tombola 4", color: Color.fromARGB(255, 51, 30, 210)),
          TombolaWidget(
              name: "Tombola 4", color: Color.fromARGB(255, 148, 145, 245)),
        ]),
        Positioned(
            bottom: 5,
            right: 5,
            child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      pageNotifier.setTombolaPage(TombolaPage.addEdit);
                    },
                    child: AddButton(
                      text: "+",
                      size: 50,
                    )))),
      ]),
    );
  }
}
