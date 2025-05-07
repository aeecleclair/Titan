import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class AddDeviceButton extends StatelessWidget {
  final Future Function() onTap;
  const AddDeviceButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
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
                        height: constraint.maxHeight - 250,
                        child: child,
                      ),
                      child: const Column(
                        children: [
                          Spacer(flex: 3),
                          Center(
                            child: HeroIcon(
                              HeroIcons.plus,
                              color: Color.fromARGB(255, 2, 2, 2),
                              size: 65,
                            ),
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
      },
    );
  }
}
