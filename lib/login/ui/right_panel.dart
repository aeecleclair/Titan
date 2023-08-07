import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RightPanel extends HookConsumerWidget {
  const RightPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController(initialPage: 0);
    final offset = useState(Offset.zero);
    final resetAnimation = useAnimationController(
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 1));
    resetAnimation.addListener(() {
      offset.value = Offset.lerp(offset.value, Offset.zero,
          Curves.easeInOut.transform(resetAnimation.value))!;
    });
    final isHovering = useState(false);
    final len = 3;
    return Row(
      children: [
        const Spacer(flex: 3),
        Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: ((context, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: LayoutBuilder(
                            builder: (context, constraints) => MouseRegion(
                              onHover: (event) {
                                if (isHovering.value) {
                                  offset.value = event.localPosition -
                                      Offset(constraints.maxWidth / 2,
                                          constraints.maxHeight / 2);
                                }
                              },
                              onExit: (event) {
                                resetAnimation.forward(from: 0);
                                isHovering.value = false;
                              },
                              onEnter: (event) {
                                resetAnimation.reverse(from: 1);
                                isHovering.value = true;
                              },
                              child: Transform(
                                // Transform widget
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001) // perspective
                                  ..rotateX(
                                      0.0003 * offset.value.dy) // changed
                                  ..rotateY(
                                      -0.0003 * offset.value.dx), // changed
                                alignment: FractionalOffset.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            width: 2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Page ${index + 1}',
                                          style: const TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    itemCount: len,
                    controller: pageController,
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: len,
                  effect: const WormEffect(
                      dotColor: Color.fromARGB(255, 211, 211, 211),
                      activeDotColor: Color.fromARGB(255, 48, 48, 48),
                      dotWidth: 20,
                      dotHeight: 20),
                  onDotClicked: (index) {
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                ),
                const SizedBox(height: 50),
              ],
            )),
        Expanded(
            flex: 5,
            child: Column(children: [
              const Spacer(),
              Image.asset('assets/images/eclair.png', width: 120, height: 120),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Développé par ECLAIR",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
            ])),
      ],
    );
  }
}
