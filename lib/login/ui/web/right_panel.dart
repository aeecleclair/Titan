import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/login/class/screen_shot.dart';
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
      reverseDuration: const Duration(milliseconds: 1),
    );
    resetAnimation.addListener(() {
      offset.value = Offset.lerp(
        offset.value,
        Offset.zero,
        Curves.easeInOut.transform(resetAnimation.value),
      )!;
    });
    final isHovering = useState(false);

    final screenShots = [
      ScreenShot(
        path: 'assets/web/Calendrier.webp',
        title: 'BDE - BDS - BDA',
        description: 'Les évènements à venir',
      ),
      ScreenShot(
        path: 'assets/web/AMAP.webp',
        title: 'Planet&Co',
        description: 'Commande de fruit et légumes',
      ),
      ScreenShot(
        path: 'assets/web/Cine.webp',
        title: 'Club Cinéma',
        description: 'Les projections à venir',
      ),
      ScreenShot(
        path: 'assets/web/Parametres.webp',
        title: 'Éclair',
        description: 'Personnalisation de l\'interface',
      ),
      ScreenShot(
        path: 'assets/web/Pret.webp',
        title: '',
        description: 'Gestion des prêts de matériel',
      ),
      ScreenShot(
        path: 'assets/web/Tombola.webp',
        title: '',
        description: 'Les tombolas proposé par plusieurs associations',
      ),
      ScreenShot(
        path: 'assets/web/Vote.webp',
        title: 'CAA',
        description: "L'éléction des nouveaux mandats",
      ),
    ];

    return Row(
      children: [
        const Spacer(flex: 3),
        Expanded(
          flex: 8,
          child: PageView.builder(
            controller: pageController,
            itemBuilder: ((context, index) {
              final screenShot =
                  screenShots[screenShots.length -
                      (initialPage - index - 1) % screenShots.length -
                      1];
              return Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      if (screenShot.title.isNotEmpty)
                        Text(
                          screenShot.title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      if (screenShot.title.isNotEmpty)
                        const Text(
                          " - ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      Expanded(
                        child: AutoSizeText(
                          screenShot.description,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) => MouseRegion(
                          onHover: (event) {
                            if (isHovering.value) {
                              offset.value =
                                  event.localPosition -
                                  Offset(
                                    constraints.maxWidth / 2,
                                    constraints.maxHeight / 2,
                                  );
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
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 2,
                                    ),
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
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  const Spacer(flex: 5),
                  SmoothPageIndicator(
                    axisDirection: Axis.vertical,
                    controller: pageController,
                    count: screenShots.length,
                    effect: const WormEffect(
                      dotColor: Colors.white,
                      activeDotColor: Color.fromARGB(255, 48, 48, 48),
                      dotWidth: 20,
                      dotHeight: 20,
                    ),
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Image.asset(
                'assets/images/proximapp.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loginMadeBy,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
