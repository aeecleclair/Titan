import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/mypayment/ui/pages/main_page/main_card_button.dart';

class MainCardTemplate extends StatelessWidget {
  final List<MainCardButton> actionButtons;
  final List<Color> colors;
  final String title;
  final Widget child;
  final Function? toggle;
  const MainCardTemplate({
    super.key,
    required this.actionButtons,
    required this.colors,
    required this.title,
    required this.child,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .fromLTRB(30, 10, 30, 0),
      decoration: BoxDecoration(
        borderRadius: .circular(30),
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: Padding(
              padding: const .symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Row(
                    children: [
                      Text(
                        title,
                        textAlign: .left,
                        style: const TextStyle(
                          color: MyPaymentColors.onGradient,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      if (toggle != null)
                        GestureDetector(
                          onTap: () {
                            toggle!();
                          },
                          child: const HeroIcon(
                            .arrowsRightLeft,
                            color: MyPaymentColors.onGradient,
                            size: 30,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: .center,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: .only(
                bottomLeft: .circular(30),
                bottomRight: .circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              children: actionButtons,
            ),
          ),
        ],
      ),
    );
  }
}
