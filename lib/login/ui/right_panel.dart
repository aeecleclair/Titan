import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    final len = 3;
    return Row(
      children: [
        Spacer(flex: 3),
        Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: ((context, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
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
                        )),
                    itemCount: len,
                    controller: pageController,
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: len,
                  effect: WormEffect(
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
                SizedBox(height: 50),
              ],
            )),
        Expanded(flex: 5,
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/eclair.png', width: 120, height: 120),
            SizedBox(height: 30,),
            Text("Développé par ECLAIR", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 50),
          ]
        )),
      ],
    );
  }
}
