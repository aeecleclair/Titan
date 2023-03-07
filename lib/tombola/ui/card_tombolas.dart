import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';

import '../providers/tombola_page_provider.dart';

class TombolaWidget extends HookConsumerWidget {
  const TombolaWidget({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return GestureDetector(
        onTap: () {
          pageNotifier.setTombolaPage(TombolaPage.tombola);
        },
        child: Center(
            child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(105, 80, 81, 81),
                    blurRadius: 6,
                    offset: Offset(1, 1)),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 250, 244, 244),
                  Color.fromARGB(255, 250, 246, 246),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              name,
              style: const TextStyle(
                  color: TombolaColorConstants.darkGradientBlueButton,
                  fontSize: 20),
            ),
            Image.asset("assets/images/logo.png"),
          ]),
        )));
  }
}
