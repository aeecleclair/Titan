import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/tools/constants.dart';

class PretendanceCard extends HookConsumerWidget {
  final Pretendance pretendance;
  final bool isCurrent;
  final bool isSelected;
  final void Function() onTap, onVote;
  final AnimationController animation;
  final int index;
  const PretendanceCard(
      {super.key,
      required this.pretendance,
      required this.isCurrent,
      required this.isSelected,
      required this.onTap,
      required this.onVote,
      required this.animation,
      required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: animation,
            curve: Interval(0.05 + 0.05 * index, 0.25 + 0.05 * index,
                curve: Curves.easeOut))),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                VoteColorConstants.green5,
                Color.fromARGB(255, 1, 40, 72),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 1, 40, 72).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(2, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                      child: HeroIcon(
                    HeroIcons.cubeTransparent,
                    color: Colors.white,
                    size: 50,
                  )),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          pretendance.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: HeroIcon(
                      isSelected ? HeroIcons.check : HeroIcons.xMark,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                "Liste ${pretendance.listType.toString().split(".").last}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              if (isCurrent)
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      pretendance.description,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: GestureDetector(
                        onTap: onVote,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(
                                    2, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Voter pour cette liste',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 40, 72),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
