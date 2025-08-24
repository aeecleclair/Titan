import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/admin_news_list_provider.dart';
import 'package:titan/feed/providers/news_list_provider.dart';
import 'package:titan/feed/tools/function.dart';
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class AdminEventCard extends ConsumerWidget {
  final News news;
  const AdminEventCard({super.key, required this.news});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAdminNotifier = ref.watch(adminNewsListProvider.notifier);
    final newsNotifier = ref.watch(newsListProvider.notifier);

    final localizeWithContext = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.title,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    news.entity,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorConstants.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const HeroIcon(
                  HeroIcons.calendar,
                  size: 16,
                  color: ColorConstants.tertiary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    getNewsSubtitle(news, context: context),
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                ),
              ],
            ),

            if (news.location != null && news.location!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const HeroIcon(
                    HeroIcons.mapPin,
                    size: 16,
                    color: ColorConstants.tertiary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    news.location!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (news.status != NewsStatus.rejected)
                  WaitingButton(
                    onTap: () async {
                      final newNews = news.copyWith(
                        status: NewsStatus.rejected,
                      );
                      await newsAdminNotifier.rejectNews(newNews);
                      await newsNotifier.loadNewsList();
                    },
                    builder: (child) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      width: 100,
                      decoration: BoxDecoration(
                        color: ColorConstants.main,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ColorConstants.onMain,
                          width: 2,
                        ),
                      ),
                      child: child,
                    ),
                    waitingColor: ColorConstants.background,
                    child: Center(
                      child: Text(
                        localizeWithContext.feedReject,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.background,
                        ),
                      ),
                    ),
                  ),
                if (news.status == NewsStatus.waitingApproval)
                  SizedBox(width: 10),
                if (news.status != NewsStatus.published)
                  WaitingButton(
                    onTap: () async {
                      final newNews = news.copyWith(
                        status: NewsStatus.published,
                      );
                      await newsAdminNotifier.approveNews(newNews);
                      await newsNotifier.loadNewsList();
                    },
                    builder: (child) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      width: 100,
                      decoration: BoxDecoration(
                        color: ColorConstants.tertiary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ColorConstants.onTertiary,
                          width: 2,
                        ),
                      ),
                      child: child,
                    ),
                    waitingColor: ColorConstants.background,
                    child: Center(
                      child: Text(
                        localizeWithContext.feedApprove,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.background,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
