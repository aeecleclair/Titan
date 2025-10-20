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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
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
          overlayColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(37, 0, 0, 0),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3),
              width: 45,
              height: 45,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    link.name,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
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
