import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/add_button.dart';

class CreateHomePage extends HookConsumerWidget {
  const CreateHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Stack(children: [
        ListView(physics: const BouncingScrollPhysics(), children: const [
          Text(
            TombolaTextConstants.createYourRaffle,
            style: TextStyle(fontSize: 30),
          ),
          Text(TombolaTextConstants.modifTombola),
          Center(
            child: Text(
              TombolaTextConstants.actualTombolas,
              style: TextStyle(fontSize: 30),
            ),
          ),
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
                    child: const AddButton(
                      text: "+",
                      size: 50,
                    )))),
      ]),
    );
  }
}
