import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/vote/providers/scroll_controller_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/voted_section_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/pretendance_card.dart';

class ListPretendenceCard extends HookConsumerWidget {
  final AnimationController animation;
  const ListPretendenceCard({super.key, required this.animation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionsPretendances = ref.watch(sectionPretendanceProvider);
    final hideAnimation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 1);

    final status = ref.watch(statusProvider);

    double h = 0;
    status.whenData((s) {
      if (s == Status.open) {
        sectionsPretendances
            .whenData((pretendanceList) => pretendanceList[section]!.whenData(
                  (pretendance) {
                    h = pretendance.length * 180 -
                        MediaQuery.of(context).size.height +
                        250;
                  },
                ));
      }
    });

    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    final votedSection = ref.watch(votedSectionProvider);
    List<String> alreadyVotedSection = [];
    votedSection.when(
        data: (voted) {
          alreadyVotedSection = voted;
        },
        error: (error, stackTrace) {},
        loading: () {});

    final pageOpened = useState(false);

    if (!pageOpened.value) {
      animation.forward();
      pageOpened.value = true;
    }
    return sectionsPretendances.when(
        data: (pretendanceList) => Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: pretendanceList.isNotEmpty
                      ? alreadyVotedSection.contains(section.id)
                          ? SizedBox(
                              height: 350,
                              width: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    HeroIcon(HeroIcons.checkCircle,
                                        color: ColorConstants.background2,
                                        size: 100),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(VoteTextConstants.alreadyVoted,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: pretendanceList[section]!.when(
                              data: (pretendance) => pretendance.map((e) {
                                final index = pretendance.indexOf(e);
                                return PretendanceCard(
                                    index: index,
                                    pretendance: e,
                                    animation: animation);
                              }).toList(),
                              loading: () => const [
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                              ],
                              error: (error, stack) => const [
                                Center(
                                  child: Text("Error occured"),
                                )
                              ],
                            ))
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
                              scrollController.animateTo(h + 25,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.decelerate);
                            }),
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(2, 0),
                                end: const Offset(0, 0),
                              ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.2, 0.4,
                                      curve: Curves.easeOut))),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        ColorConstants.background2
                                            .withOpacity(0.8),
                                        Colors.black.withOpacity(0.8)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorConstants.background2
                                            .withOpacity(0.4),
                                        offset: const Offset(2, 3),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HeroIcon(
                                      HeroIcons.chevronDoubleDown,
                                      size: 15,
                                      color: Colors.grey.shade100,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
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
                      ))
              ],
            ),
        error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text("Error occured"));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        });
  }
}
