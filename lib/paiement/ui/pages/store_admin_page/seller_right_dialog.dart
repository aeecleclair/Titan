import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 50.0;
  static const Color gradient1 = Color.fromARGB(255, 6, 75, 75);
  static const Color gradient2 = Color.fromARGB(255, 0, 29, 29);
}

class SellerRightDialog extends StatelessWidget {
  final String title;
  final Function() onYes;
  final Widget? child;

  const SellerRightDialog({
    super.key,
    required this.title,
    required this.onYes,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black54,
        child: GestureDetector(
          onTap: () {},
          child: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            elevation: 0.0,
            insetPadding: const EdgeInsets.all(20.0),
            backgroundColor: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: Consts.avatarRadius + Consts.padding,
                    bottom: Consts.padding,
                    left: Consts.padding,
                    right: Consts.padding,
                  ),
                  margin: const EdgeInsets.only(top: Consts.avatarRadius),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(Consts.padding),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      if (child != null) child!,
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WaitingButton(
                            onTap: () async {
                              await onYes();
                            },
                            waitingColor: Colors.black,
                            builder: (child) => Container(
                              width:
                                  MediaQuery.of(context).size.width -
                                  4 * Consts.padding,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.3),
                                    blurRadius: 2.0,
                                    offset: const Offset(1.0, 2.0),
                                  ),
                                ],
                              ),
                              child: child,
                            ),
                            child: const Center(
                              child: Text(
                                "Ajouter",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: Consts.padding,
                  right: Consts.padding,
                  child: Container(
                    width: Consts.avatarRadius * 2,
                    height: Consts.avatarRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Consts.gradient1, Consts.gradient2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Consts.gradient2.withValues(alpha: 0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: HeroIcon(
                        HeroIcons.exclamationCircle,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
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
