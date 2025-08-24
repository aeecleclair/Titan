import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 50.0;
  static const Color redGradient1 = Color(0xFF9E131F);
  static const Color redGradient2 = Color(0xFF590512);
}

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions;
  final String? yesText, noText;
  final Function() onYes;
  final Function()? onNo;

  const CustomDialogBox({
    super.key,
    required this.title,
    required this.descriptions,
    required this.onYes,
    this.onNo,
    this.yesText,
    this.noText,
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
                      Text(
                        descriptions,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              onNo == null
                                  ? Navigator.of(context).pop()
                                  : onNo?.call();
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [Colors.black87, Colors.black],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 2.0,
                                    offset: const Offset(1.0, 2.0),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  noText ??
                                      AppLocalizations.of(
                                        context,
                                      )!.globalCancel,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          WaitingButton(
                            onTap: () async {
                              if (onNo == null) {
                                Navigator.of(context).pop();
                              }
                              await onYes();
                            },
                            waitingColor: Colors.black,
                            builder: (child) => Container(
                              width: 100,
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
                            child: Center(
                              child: Text(
                                yesText ??
                                    AppLocalizations.of(context)!.globalConfirm,
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
                        colors: [Consts.redGradient1, Consts.redGradient2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Consts.redGradient2.withValues(alpha: 0.3),
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
