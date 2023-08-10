import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/tools/tag_chip.dart';

class AdvertCard extends StatelessWidget {
  final VoidCallback onTap;
  final Advert advert;

  const AdvertCard({Key? key, required this.onTap, required this.advert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 300;
    double height = 300;
    double imageHeight = 200;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x33000000),
              offset: Offset(2, 2),
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: width,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                        'https://picsum.photos/seed/664/600',
                      ).image,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height - imageHeight,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                AutoSizeText(
                                  advert.title,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  minFontSize: 14,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                          overflow: TextOverflow.ellipsis,
                          advert.content,
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: imageHeight - 23,
              left: 20,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.4),
                      offset: const (2, 2),
                      spreadRadius: 3,
                    )
                  ]),
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: AutoSizeText(
                    DateFormat('dd/MM\nyyyy').format(advert.date),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: imageHeight - 20,
              right: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: advert.announcer
                    .map((e) => TagChip(
                          tagname: e,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
