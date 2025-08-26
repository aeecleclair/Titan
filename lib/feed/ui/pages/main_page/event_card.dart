import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/news_image_provider.dart';
import 'package:titan/feed/providers/news_images_provider.dart';
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/feed/ui/widgets/adaptive_text_card.dart';
import 'package:titan/feed/ui/widgets/event_card_text_content.dart';
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
            dataBuilder: (context, value) => AdaptiveTextCard(
              hasImage: value.isNotEmpty,
              imageProvider: value.isNotEmpty ? value.first.image : null,
              child: Container(
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
          ),
          EventCardTextContent(
            item: item,
            localizeWithContext: localizeWithContext,
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
