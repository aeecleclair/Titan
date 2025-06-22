import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_poster_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/ui/components/tag_chip.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/text_with_hyper_link.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertDetailPage extends HookConsumerWidget {
  const AdvertDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertId = QR.params['advertId'].toString();
    final asyncAdvert = ref.watch(singleAdvertProvider(advertId));

    final advertPostersNotifier = ref.read(advertPostersProvider.notifier);
    final logoNotifier = ref.read(advertPosterProvider.notifier);
    DateTime? advertDate;

    Widget widget = asyncAdvert.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (advert) {
        if (advert == null) {
          return const Center(child: Text('Advert not found'));
        }
        final posters = ref.watch(
          advertPostersProvider.select(
            (advertPosters) => advertPosters[advert.id],
          ),
        );
        advertDate = advert.date;
        return AdvertDetail(
          posters: posters,
          advertPostersNotifier: advertPostersNotifier,
          advert: advert,
          logoNotifier: logoNotifier,
        );
      },
    );

    return Stack(
      children: [
        widget,
        TopBar(date: advertDate),
      ],
    );
  }
}

class AdvertDetail extends StatelessWidget {
  const AdvertDetail({
    super.key,
    required this.posters,
    required this.advertPostersNotifier,
    required this.advert,
    required this.logoNotifier,
  });

  final AsyncValue<List<Image>>? posters;
  final AdvertPostersNotifier advertPostersNotifier;
  final Advert advert;
  final AdvertPosterNotifier logoNotifier;

  @override
  Widget build(BuildContext context) {
    final filteredTagList = advert.tags
        .where((element) => element != "")
        .toList();
    final inTagChipsList = [advert.announcer.name] + filteredTagList;

    return Stack(
      children: [
        AdvertBackground(
          posters: posters,
          advertPostersNotifier: advertPostersNotifier,
          advert: advert,
          logoNotifier: logoNotifier,
        ),
        AdvertContent(advert: advert, inTagChipsList: inTagChipsList),
      ],
    );
  }
}

class AdvertBackground extends StatelessWidget {
  const AdvertBackground({
    super.key,
    required this.posters,
    required this.advertPostersNotifier,
    required this.advert,
    required this.logoNotifier,
  });

  final AsyncValue<List<Image>>? posters;
  final AdvertPostersNotifier advertPostersNotifier;
  final Advert advert;
  final AdvertPosterNotifier logoNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mapKey: advert.id,
        loader: (ref) => logoNotifier.getAdvertPoster(advert.id),
        dataBuilder: (context, value) =>
            Image(image: value.first.image, fit: BoxFit.fill),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 45),
        Row(
          children: [
            const SizedBox(width: 20),
            BackButton(),
            const Spacer(),
            date != null ? DateChip(date: date!) : Container(),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}

class AdvertContent extends StatelessWidget {
  const AdvertContent({
    super.key,
    required this.advert,
    required this.inTagChipsList,
  });

  final Advert advert;
  final List<String> inTagChipsList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                HorizontalListView.builder(
                  height: 35,
                  horizontalSpace: 30,
                  items: inTagChipsList,
                  itemBuilder: (BuildContext context, String item, int index) =>
                      TagChip(tagName: item),
                ),
                const SizedBox(height: 15),
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
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

class DateChip extends StatelessWidget {
  const DateChip({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
            DateFormat('dd/MM/yyyy - HH:mm').format(date),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
