import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/centralassociation/class/link.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:titan/centralassociation/tools/constants.dart';
import 'package:titan/centralassociation/tools/functions.dart';

class LinkCard extends HookConsumerWidget {
  final Link link;
  const LinkCard({super.key, required this.link});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      height: 70,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: link.icon.endsWith('.svg')
                  ? SvgPicture.network(
                      "${CentralassociationTextConstants.imagePath}${link.icon}",
                    )
                  : Image.network(
                      "${CentralassociationTextConstants.imagePath}${link.icon}",
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 7),
                child: AutoSizeText(
                  link.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  minFontSize: 10,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          openLink(link.url);
        },
      ),
    );
  }
}
