import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_poster_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/text_with_hyper_link.dart';

class AdvertCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final Advert advert;

  const AdvertCard({Key? key, required this.onTap, required this.advert})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 300;
    double height = 300;
    double imageHeight = 175;
    double maxHeight = MediaQuery.of(context).size.height - 344;
    final advertPosters = ref.watch(advertPostersProvider);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final logoNotifier = ref.watch(advertPosterProvider.notifier);
    final isWebFormat = ref.watch(isWebFormatProvider);
    return GestureDetector(
      onTap: () {
        if (!isWebFormat) {
          onTap();
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(isWebFormat ? 50 : 0),
        child: AutoLoaderChild(
          value: advertPosters,
          notifier: advertPostersNotifier,
          mapKey: advert,
          loader: (ref) => logoNotifier.getAdvertPoster(advert.id),
          loadingBuilder: (context) => HeroIcon(
            HeroIcons.photo,
            size: width,
          ),
          dataBuilder: (context, value) => isWebFormat
              ? Container(
                  height: maxHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image(
                            image: value.first.image,
                            fit: BoxFit.cover, // use this
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(advert.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(formatDate(advert.date),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWithHyperLink(advert.content,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                )
              : Container(
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
                      Column(children: [
                        Container(
                          width: width,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            image: DecorationImage(
                              image: value.first.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          width: width,
                          height: height - imageHeight,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: width,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: AutoSizeText(
                                      advert.title.trim(),
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
                              TextWithHyperLink(
                                advert.content.trim(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                maxLines: 3,
                                minFontSize: 13,
                                maxFontSize: 15,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      Positioned(
                        top: imageHeight - 40,
                        left: 15,
                        child: Container(
                          decoration: BoxDecoration(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
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
                                    AdvertTextConstants.months[int.parse(
                                            DateFormat('MM')
                                                .format(advert.date)) -
                                        1],
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
                          decoration: BoxDecoration(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            child: Container(
                              color: Colors.white,
                              height: 30,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
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
        ),
      ),
    );
  }
}
