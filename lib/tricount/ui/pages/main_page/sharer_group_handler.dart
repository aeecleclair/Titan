import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_group_card.dart';

class SharerGroupHandler extends HookConsumerWidget {
  final List<SharerGroup> sharerGroups;
  final PageController pageController;
  final double viewPortFraction;
  const SharerGroupHandler(
      {super.key,
      required this.sharerGroups,
      required this.pageController,
      required this.viewPortFraction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offset = useState<double>(sharerGroups.length - 1);
    pageController.addListener(() {
      offset.value = pageController.offset / (360 * viewPortFraction);
    });

    return SizedBox(
        height: 300,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 45),
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            controller: pageController,
            itemCount: sharerGroups.length,
            reverse: true,
            itemBuilder: (context, index) => SharerGroupCard(
                sharerGroup: sharerGroups.reversed.toList()[index],
                depth: index,
                offset: offset.value),
          ),
        ));
  }
}
