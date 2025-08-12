import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/providers/advert_poster_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdvertCard extends HookConsumerWidget {
  final Advert advert;

  const AdvertCard({super.key, required this.advert});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final posters = ref.watch(
      advertPostersProvider.select((advertPosters) => advertPosters[advert.id]),
    );
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final posterNotifier = ref.watch(advertPosterProvider.notifier);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      advert.announcer.name.isNotEmpty
                          ? advert.announcer.name
                                .split(' ')
                                .take(2)
                                .map((s) => s[0].toUpperCase())
                                .join()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        advert.announcer.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        _capitalizeFirst(
                          timeago.format(advert.date, locale: 'fr_short'),
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          AutoLoaderChild(
            group: posters,
            notifier: advertPostersNotifier,
            mapKey: advert.id,
            loader: (advertId) => posterNotifier.getAdvertPoster(advertId),
            loadingBuilder: (context) => AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.onBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: HeroIcon(HeroIcons.photo, size: 50)),
              ),
            ),
            dataBuilder: (context, value) => AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.onBackground,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: value.first.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildExpandableText(isExpanded)],
            ),
          ),
        ],
      ),
    );
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget _buildExpandableText(ValueNotifier<bool> isExpanded) {
    final title = advert.title.trim();
    final content = advert.content.trim();

    final fullText = title.isNotEmpty ? '$title $content' : content;

    const maxLength = 100;

    final isLong = fullText.length > maxLength;

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 14, height: 1.4),
        children: [
          if (title.isNotEmpty) ...[
            TextSpan(
              text: title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: '  '),
          ],
          TextSpan(
            text: isLong && !isExpanded.value
                ? '${content.substring(0, maxLength)}...'
                : content,
          ),
          if (isLong) ...[
            const TextSpan(text: '  '),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: () {
                  isExpanded.value = !isExpanded.value;
                },
                child: Text(
                  isExpanded.value ? 'voir moins' : 'voir plus',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
