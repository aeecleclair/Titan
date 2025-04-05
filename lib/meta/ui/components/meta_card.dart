import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_poster_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/text_with_hyper_link.dart';

class MetaCardBuilder {
  String? title;
  String? content;
  String? date;
  String? announcer;
  String? image;
  List<String>? tags;

  MetaCardBuilder setTitle(String title) {
    this.title = title;
    return this;
  }

  MetaCardBuilder setContent(String content) {
    this.content = content;
    return this;
  }

  MetaCardBuilder setDate(String date) {
    this.date = date;
    return this;
  }

  MetaCardBuilder setAnnouncer(String announcer) {
    this.announcer = announcer;
    return this;
  }

  MetaCardBuilder setImage(String image) {
    this.image = image;
    return this;
  }

  MetaCardBuilder setTags(List<String> tags) {
    this.tags = tags;
    return this;
  }
}

class AdvertCardBuilder extends MetaCardBuilder {
  String? countdown;

  AdvertCardBuilder setCountdown(String countdown) {
    this.countdown = countdown;
    return this;
  }
}

enum MetaCardType { event, advert, shotgun }

class MetaCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final Advert meta;

  const MetaCard({super.key, required this.onTap, required this.meta});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 340;
    double height = 300;
    double imageHeight = 120;
    double maxHeight = MediaQuery.of(context).size.height - 344;
    final posters = ref.watch(
      advertPostersProvider.select((advertPosters) => advertPosters[meta.id]),
    );
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final posterNotifier = ref.watch(advertPosterProvider.notifier);
    final isWebFormat = ref.watch(isWebFormatProvider);

    return GestureDetector(
      onTap: () {
        if (!isWebFormat) {
          onTap();
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.all(isWebFormat ? 50 : 0),
        child: isWebFormat
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
                        child: AutoLoaderChild(
                          group: posters,
                          notifier: advertPostersNotifier,
                          mapKey: meta.id,
                          loader: (advertId) =>
                              posterNotifier.getAdvertPoster(advertId),
                          loadingBuilder: (context) => HeroIcon(
                            HeroIcons.photo,
                            size: width,
                          ),
                          dataBuilder: (context, value) => Image(
                            image: value.first.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        children: [
                          AutoSizeText(
                            meta.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                            formatDate(meta.date),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextWithHyperLink(
                                meta.content,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
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
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          width: width,
                          height: height - imageHeight,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey.shade300,
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            meta.announcer.name.trim(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Jutssou".trim(),
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat('HH:mm dd/MM/yy')
                                        .format(meta.date),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: width,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: AutoSizeText(
                                      meta.title.trim(),
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
                              Expanded(
                                child: TextWithHyperLink(
                                  meta.content.trim(),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  maxLines: false ? 3 : 6,
                                  minFontSize: 13,
                                  maxFontSize: 15,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                              /*if (false)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Center(
                                    // <-- Ajout du centrage
                                    child: Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // <-- Permet au Row de s'ajuster à son contenu
                                      children: [
                                        const Icon(Icons.timer,
                                            size: 20, color: Colors.red),
                                        const SizedBox(width: 4),
                                        Text(
                                          _countdown,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
