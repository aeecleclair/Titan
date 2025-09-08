import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/vote/providers/result_provider.dart';
import 'package:titan/vote/providers/scroll_controller_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/providers/voted_section_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/tools/constants.dart';
import 'package:titan/vote/ui/pages/main_page/contender_card.dart';

class ListContenderCard extends HookConsumerWidget {
  final AnimationController animation;
  const ListContenderCard({super.key, required this.animation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionsContender = ref.watch(sectionContenderProvider);
    final hideAnimation = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: 1,
    );

    final status = ref.watch(statusProvider);
    final s = status.maybeWhen(
      data: (value) => value,
      orElse: () => Status.closed,
    );

    Map<String, int> results = {};
    if (s == Status.published) {
      ref.watch(resultProvider).whenData((data) {
        for (var i = 0; i < data.length; i++) {
          results[data[i].id] = data[i].count;
        }
      });
    }

    int totalVotes = 0;
    Map<String, double> votesPercent = {};

    double h = 0;
    sectionsContender[section]!.whenData((contenderList) {
      h =
          contenderList.length *
              ((s == Status.open || s == Status.published) ? 180 : 140) -
          MediaQuery.of(context).size.height +
          (s == Status.open ? 250 : 150);
      List<int> numberVotes = [];
      for (var i = 0; i < contenderList.length; i++) {
        numberVotes.add(results[contenderList[i].id] ?? 0);
      }
      totalVotes = numberVotes.reduce((value, element) => value + element);
      for (var i = 0; i < numberVotes.length; i++) {
        votesPercent[contenderList[i].id] = totalVotes == 0
            ? 0
            : numberVotes[i] / totalVotes;
      }
    });

    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    final votedSection = ref.watch(votedSectionProvider);
    List<String> alreadyVotedSection = [];
    votedSection.maybeWhen(
      data: (voted) {
        alreadyVotedSection = voted;
      },
      orElse: () {},
    );

    final pageOpened = useState(false);

    if (!pageOpened.value) {
      animation.forward();
      pageOpened.value = true;
    }
    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: sectionsContender.isNotEmpty
              ? AsyncChild(
                  value: sectionsContender[section]!,
                  builder: (context, contenderList) => Column(
                    children: contenderList.map((e) {
                      final index = contenderList.indexOf(e);
                      return ContenderCard(
                        index: index,
                        contender: e,
                        animation: animation,
                        enableVote: !alreadyVotedSection.contains(section.id),
                        votesPercent: votesPercent.keys.contains(e.id)
                            ? votesPercent[e.id]!
                            : 0,
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(VoteTextConstants.noPretendanceList),
                  ),
                ),
        ),
        if (h > 0)
          Positioned(
            bottom: 10,
            right: MediaQuery.of(context).size.width / 2 - 100,
            child: FadeTransition(
              opacity: hideAnimation,
              child: ScaleTransition(
                scale: hideAnimation,
                child: GestureDetector(
                  onTap: (() {
                    hideAnimation.animateTo(0);
                    scrollController.animateTo(
                      h + 25,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.decelerate,
                    );
                  }),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(2, 0),
                          end: const Offset(0, 0),
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0.2,
                              0.4,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorConstants.background2.withValues(alpha: 0.8),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.background2.withValues(
                              alpha: 0.4,
                            ),
                            offset: const Offset(2, 3),
                            blurRadius: 5,
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HeroIcon(
                            HeroIcons.chevronDoubleDown,
                            size: 15,
                            color: Colors.grey.shade100,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            VoteTextConstants.seeMore,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
