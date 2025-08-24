import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/news_image_provider.dart';
import 'package:titan/feed/providers/news_images_provider.dart';
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';

class EventCard extends ConsumerWidget {
  final News item;

  const EventCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(
      newsImagesProvider.select((newsImages) => newsImages[item.id]),
    );
    final newsImagesNotifier = ref.watch(newsImagesProvider.notifier);
    final imageNotifier = ref.watch(newsImageProvider.notifier);
    final localizeWithContext = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        if (item.module == "advert") {
          QR.to(AdvertRouter.root);
        }
      },
      child: Stack(
        children: [
          AutoLoaderChild(
            group: images,
            notifier: newsImagesNotifier,
            mapKey: item.id,
            loader: (itemId) => imageNotifier.getNewsImage(itemId),
            orElseBuilder: (context, stack) => Container(
              width: double.infinity,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [ColorConstants.onMain, ColorConstants.main],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            dataBuilder: (context, value) => Container(
              width: double.infinity,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: value.isEmpty
                    ? null
                    : DecorationImage(
                        image: value.first.image,
                        fit: BoxFit.cover,
                      ),
                gradient: value.isNotEmpty
                    ? null
                    : const LinearGradient(
                        colors: [ColorConstants.onMain, ColorConstants.main],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Row(
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: ColorConstants.background,
                      ),
                    ),
                    if (item.location != null && item.location!.isNotEmpty)
                      Text(
                        ' | ${item.location}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorConstants.background,
                        ),
                      ),
                  ],
                ),
                Text(
                  getNewsSubtitle(item, context: context),
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstants.background,
                  ),
                ),
              ],
            ),
          ),
          if (isNewsTerminated(item) && item.module != "advert")
            Positioned(
              bottom: 53,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                  color: ColorConstants.main,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  localizeWithContext.feedEnded,
                  style: TextStyle(
                    color: ColorConstants.background,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          if (isNewsOngoing(item) && item.module != "advert")
            Positioned(
              bottom: 53,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                  color: ColorConstants.background,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  localizeWithContext.feedOngoing,
                  style: TextStyle(color: ColorConstants.main, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
