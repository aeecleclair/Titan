import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/tools/constants.dart';

class AdvertCard extends StatelessWidget {
  final VoidCallback onTap;
  final Advert advert;

  const AdvertCard({Key? key, required this.onTap, required this.advert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 300;
    double height = 300;
    double imageHeight = 175;
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
                Container(
                  padding: const EdgeInsets.only(top:20,left:10,right:10),
                  width: width,
                  height: height - imageHeight,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 5),
                            child:
                                AutoSizeText(
                                  advert.title,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  minFontSize: 15,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child: AutoSizeText(
                          overflow: TextOverflow.ellipsis,
                          advert.content,
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          minFontSize: 13,
                          maxFontSize: 15,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: imageHeight - 40,
              left: 15,
              child: Container(
                decoration:  BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        spreadRadius: 3,
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          DateFormat('dd').format(advert.date),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                                                AutoSizeText(
                          AdvertTextConstants.months[int.parse(DateFormat('MM').format(advert.date))-1],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: imageHeight - 20,
              right: 15,
              child: Container(
                decoration:  BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        spreadRadius: 3,
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: Colors.white,
                    height: 30,
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                          advert.announcer.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
