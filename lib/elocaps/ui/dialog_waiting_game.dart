import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/tools/constants.dart';

void maybeShowDialog(context) {
  const bool isWaited = true; ///////////

  if (isWaited) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const WaitingDialog();
      },
    );
  }
}

class WaitingDialog extends HookConsumerWidget {
  const WaitingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = MediaQuery.of(context).size.width - 10;

    final animation = useAnimationController(
        duration: const Duration(milliseconds: 7000), initialValue: 0)
      ..repeat();

    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                  width: width,
                  height: MediaQuery.of(context).size.height / 3,
                  margin: const EdgeInsets.only(left: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(105, 35, 21, 0),
                          blurRadius: 10,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: RadialGradient(
                          colors: const [
                            Color.fromARGB(235, 255, 255, 255),
                            Color.fromARGB(205, 235, 235, 235),
                          ],
                          transform: GradientRotation(
                              360 * animation.value * pi / 180),
                          center: Alignment.bottomRight,
                          radius: 1.5)),
                  child: const SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "[user (à faire)] ${ElocapsTextConstant.is_challenging_you} [mode]"),
                            Row(
                              children: [
                                MyButton(text: ElocapsTextConstant.i_accept),
                                MyButton(
                                    text:
                                        ElocapsTextConstant.no_i_dont_like_him)
                              ],
                            )
                          ]))));
        });
  }
}
