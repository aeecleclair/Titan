import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';

class TombolaWidget extends HookConsumerWidget {
  final String name;
  const TombolaWidget({Key? key, required this.name}) : super(key: key);

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
          margin: const EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset("assets/images/logo.png", height: 80),
            AutoSizeText(
              name,
              maxLines: 2,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ]),
        )));
  }
}
