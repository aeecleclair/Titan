import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/advert/providers/advert_poster_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/ui/tools/tag_chip.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertDetailPage extends HookConsumerWidget {
  const AdvertDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advert = ref.watch(advertProvider);
    final advertPosters = ref.watch(advertPostersProvider);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final logoNotifier = ref.watch(advertPosterProvider.notifier);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: advertPosters.when(
                    data: (data) {
                      if (data[advert] != null) {
                        return data[advert]!.when(data: (data) {
                          if (data.isNotEmpty) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: data.first.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          } else {
                            Future.delayed(const Duration(milliseconds: 1), () {
                              advertPostersNotifier.setTData(
                                  advert, const AsyncLoading());
                            });
                            tokenExpireWrapper(ref, () async {
                              logoNotifier
                                  .getAdvertPoster(advert.id)
                                  .then((value) {
                                advertPostersNotifier.setTData(
                                    advert, AsyncData([value]));
                              });
                            });
                            return const HeroIcon(
                              HeroIcons.photo,
                            );
                          }
                        }, loading: () {
                          return const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }, error: (error, stack) {
                          return const SizedBox(
                            child: Center(
                              child: HeroIcon(HeroIcons.exclamationCircle),
                            ),
                          );
                        });
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error $error'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top:30),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                  spreadRadius: 3,
                                  offset: const Offset(2, 2),
                                ),
                              ]),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 3,
                              spreadRadius: 3,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const HeroIcon(
                              HeroIcons.calendar,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy - HH:mm').format(advert.date),
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade50,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    advert.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ([advert.announcer.name] + advert.tags).length,
                    itemBuilder: (BuildContext context, int index) {
                      return TagChip(
                          tagname:
                              ([advert.announcer.name] + advert.tags)[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              advert.content,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
