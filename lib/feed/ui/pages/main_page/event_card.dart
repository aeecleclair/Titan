import 'package:flutter/material.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/news_status_helper.dart';
import 'package:titan/tools/constants.dart';

class EventCard extends StatelessWidget {
  final News item;

  const EventCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.secondary,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: ColorConstants.background,
                  ),
                ),
                Text(
                  getNewsSubtitle(
                    item,
                    locale: Localizations.localeOf(context).languageCode,
                    context: context,
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstants.background,
                  ),
                ),
              ],
            ),
          ),
          if (isNewsTerminated(item))
            Positioned(
              bottom: 53,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                  color: ColorConstants.main,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Text(
                  'Terminé',
                  style: TextStyle(
                    color: ColorConstants.background,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          if (isNewsOngoing(item))
            Positioned(
              bottom: 53,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: const BoxDecoration(
                  color: ColorConstants.background,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Text(
                  'En cours',
                  style: TextStyle(color: ColorConstants.main, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
