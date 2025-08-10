import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/advert/providers/advert_poster_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/providers/advert_provider.dart';
import 'package:titan/cinema/tools/functions.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/widgets/text_with_hyper_link.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertDetailPage extends HookConsumerWidget {
  const AdvertDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advert = ref.watch(advertProvider);
    final posters = ref.watch(
      advertPostersProvider.select((advertPosters) => advertPosters[advert.id]),
    );
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final logoNotifier = ref.watch(advertPosterProvider.notifier);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: AutoLoaderChild(
            group: posters,
            notifier: advertPostersNotifier,
            mapKey: advert,
            loader: (ref) => logoNotifier.getAdvertPoster(advert.id),
            dataBuilder: (context, value) =>
                Image(image: value.first.image, fit: BoxFit.fill),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 220),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(0, 255, 255, 255),
                      Colors.grey.shade50.withValues(alpha: 0.85),
                      Colors.grey.shade50,
                    ],
                    stops: const [0.0, 0.65, 1.0],
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade50,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      alignment: Alignment.center,
                      child: Text(
                        formatDate(advert.date),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextWithHyperLink(
                        advert.content,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 45),
            Row(
              children: [
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: QR.back,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 7,
                          spreadRadius: 2,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 7,
                        spreadRadius: 2,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const HeroIcon(HeroIcons.calendar, size: 20),
                      const SizedBox(width: 7),
                      Text(
                        DateFormat('dd/MM/yyyy - HH:mm').format(advert.date),
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
