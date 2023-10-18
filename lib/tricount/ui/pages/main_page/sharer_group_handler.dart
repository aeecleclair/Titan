import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_card_layout.dart';
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
              itemCount: sharerGroups.length + 1,
              reverse: true,
              itemBuilder: (context, index) {
                if (index == sharerGroups.length) {
                  return SharerCardLayout(
                    depth: index,
                      offset: offset.value,
                      child: const Center(
                        child: HeroIcon(
                          HeroIcons.plus,
                          color: Color(0xff09263D),
                          size: 60
                        )
                      )
                  );
                }
                  return SharerGroupCard(
                      sharerGroup: sharerGroups.reversed.toList()[index],
                      depth: index,
                      offset: offset.value);
              }),
        ));
  }
}
