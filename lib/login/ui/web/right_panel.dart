import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/class/screen_shot.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RightPanel extends HookConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For "infinite" scroll in both direction
    const initialPage = 1000;
    final pageController = PageController(initialPage: initialPage);
    final offset = useState(Offset.zero);
    final resetAnimation = useAnimationController(
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 1));
    resetAnimation.addListener(() {
      offset.value = Offset.lerp(offset.value, Offset.zero,
          Curves.easeInOut.transform(resetAnimation.value))!;
    });
    final isHovering = useState(false);
    final screenShots = [
      ScreenShot(
          path: 'assets/web/Calendrier.webp',
          title: 'BDE - BDS - BDA',
          description: 'Les évènements à venir'),
      ScreenShot(
          path: 'assets/web/AMAP.webp',
          title: 'Planet&Co',
          description: 'Commande de fruit et légumes'),
      ScreenShot(
          path: 'assets/web/Ciné.webp',
          title: 'Club Cinéma',
          description: 'Les projections à venir'),
      ScreenShot(
          path: 'assets/web/Parametres.webp',
          title: 'Éclair',
          description: 'Personnalisation de l\'interface'),
      ScreenShot(
          path: 'assets/web/Pret.webp',
          title: '',
          description: 'Gestion des prêts de matériel'),
      ScreenShot(
          path: 'assets/web/Tombola.webp',
          title: '',
          description: 'Les tombolas proposé par plusieurs associations'),
      ScreenShot(
          path: 'assets/web/Vote.webp',
          title: 'CAA',
          description: "L'éléction des nouveaux mandats"),
    ];

    return Stack(
      children: [
        if (MediaQuery.sizeOf(context).width > 1000 ||
            MediaQuery.sizeOf(context).width < 750)
          const Positioned(bottom: 30, right: 15, child: EclairLogo()),
        Positioned(
          left: 15,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                SizedBox(
                  width: 350,
                  height: MediaQuery.sizeOf(context).height - 60,
                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: ((context, index) {
                      final screenShot = screenShots[screenShots.length -
                          (initialPage - index - 1) % screenShots.length -
                          1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    height: 60,
                                    child: screenShot.title.isNotEmpty
                                        ? Flexible(
                                            child: Column(
                                              children: [
                                                AutoSizeText(
                                                  screenShot.title,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                AutoSizeText(
                                                  screenShot.description,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              child: LayoutBuilder(
                                builder: (context, constraints) => MouseRegion(
                                  onHover: (event) {
                                    if (isHovering.value) {
                                      offset.value = event.localPosition -
                                          Offset(constraints.minWidth / 2,
                                              constraints.minHeight / 2);
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
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.0005)
                                      ..rotateX(0.0005 * offset.value.dy)
                                      ..rotateY(-0.0005 * offset.value.dx),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                width: 2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset(
                                              screenShot.path,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 200.0),
                  child: SmoothPageIndicator(
                    axisDirection: Axis.vertical,
                    controller: pageController,
                    count: screenShots.length,
                    effect: const WormEffect(
                        dotColor: Colors.white,
                        activeDotColor: Color.fromARGB(255, 48, 48, 48),
                        dotWidth: 20,
                        dotHeight: 20),
                    onDotClicked: (index) {
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EclairLogo extends StatelessWidget {
  const EclairLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.4),
                border:
                    Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Image.asset('assets/images/eclair.png',
                  width: 120, height: 120),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Développée par ECLAIR",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
