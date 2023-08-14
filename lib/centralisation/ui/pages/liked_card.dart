import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecl/centralisation/tools/functions.dart';

class LikedCard extends StatelessWidget {
  final Module module;
  const LikedCard({Key? key, required this.module}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openLink(module.url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(2, 3),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    child: module.icon.toLowerCase().endsWith('.svg')
                        ? SvgPicture.network(
                            "https://centralisation.eclair.ec-lyon.fr/assets/icons/${module.icon}",
                            width: 30,
                            height: 30,
                          )
                        : Image.network(
                            "https://centralisation.eclair.ec-lyon.fr/assets/icons/${module.icon}",
                            width: 30,
                            height: 30,
                          ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 30,
                    padding: const EdgeInsets.only(bottom: 7),
                    child: AutoSizeText(
                      module.name,
                      style: const TextStyle(fontSize: 16),
                      minFontSize: 10,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
