import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class AddDeviceButton extends StatelessWidget {
  final Future Function() onTap;
  const AddDeviceButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.grey.shade200.withValues(alpha: 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WaitingButton(
                  onTap: onTap,
                  builder: (child) => SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: child,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          HeroIcon(
                            HeroIcons.devicePhoneMobile,
                            color: Color(0xff204550),
                            size: 30,
                          ),
                          Positioned(
                            right: 2,
                            top: -3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200.withValues(
                                  alpha: 0.9,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: HeroIcon(
                                HeroIcons.plus,
                                color: Color(0xff204550),
                                size: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "Ajouter cet appareil",
                        style: TextStyle(
                          color: Color(0xff204550),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
