import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tombola_page_provider.dart';

class TombolaWidget extends HookConsumerWidget {
  const TombolaWidget({
    Key? key,
    required this.name,
    required this.color,
  }) : super(key: key);
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return GestureDetector(onTap: () {pageNotifier.setTombolaPage(TombolaPage.tombola);},child:Center(
        child: Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 50),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    this.color.withOpacity(0.4),
                    this.color,
                  ],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ))));
  }
}
