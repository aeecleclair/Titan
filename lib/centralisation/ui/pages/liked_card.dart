import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:titan/centralisation/class/module.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:titan/centralisation/tools/functions.dart';

class LikedCard extends StatelessWidget {
  final Module module;
  const LikedCard({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: SizedBox(
        width: 92,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.25),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => openLink(module.url),
              onLongPress: () => showLinkDetails(context, module),
              child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: module.icon.endsWith('.svg')
                        ? SvgPicture.network(
                            "${CentralisationTextConstants.imagePath}${module.icon}",
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            "${CentralisationTextConstants.imagePath}${module.icon}",
                            fit: BoxFit.contain,
                          ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: AutoSizeText(
                        module.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        minFontSize: 9,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
