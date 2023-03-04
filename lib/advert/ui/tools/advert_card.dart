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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 300,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              'https://picsum.photos/seed/664/600',
            ).image,
          ),
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
        child: Column(
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.0),
                          ],
                          stops: const [0.7, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 1,
                          ),
                          AutoSizeText(
                            advert.title,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            minFontSize: 18,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AutoSizeText(
                            "${AdvertTextConstants.the} ${DateFormat('dd/MM/yyyy\tHH:mm').format(advert.date)} - ${AdvertTextConstants.by} ${advert.author}",
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
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
            const Spacer(),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.5),
                    ],
                    stops: const [0.0, 0.3],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 10, left: 12, right: 12),
                  child: AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      advert.content,
                      textAlign: TextAlign.justify,
                      maxLines: 5,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
