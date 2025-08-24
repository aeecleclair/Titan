import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/admin_news_list_provider.dart';
import 'package:titan/feed/tools/function.dart';
import 'package:titan/feed/tools/news_filter_type.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/event_handling_page/admin_event_card.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';

class EventHandlingPage extends HookConsumerWidget {
  const EventHandlingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsListAsync = ref.watch(adminNewsListProvider);
    final newsListNotifier = ref.watch(adminNewsListProvider.notifier);
    final selectedFilter = useState(NewsFilterType.pending);

    final localizeWithContext = AppLocalizations.of(context)!;

    return FeedTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Refresher(
          onRefresh: () {
            return newsListNotifier.loadNewsList();
          },
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              Text(
                localizeWithContext.feedEventManagement,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 40,
                child: HorizontalMultiSelect<NewsFilterType>(
                  items: NewsFilterType.values,
                  selectedItem: selectedFilter.value,
                  itemBuilder: (context, item, _, selected) {
                    final filterName = _getFilterName(context, item);
                    return Text(
                      filterName,
                      style: TextStyle(
                        color: selected
                            ? ColorConstants.background
                            : ColorConstants.tertiary,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    );
                  },
                  onItemSelected: (item) {
                    selectedFilter.value = item;
                  },
                ),
              ),

              const SizedBox(height: 16),

              AsyncChild(
                value: newsListAsync,
                builder: (context, newsList) {
                  final filteredNews = _getFilteredNews(
                    newsList,
                    selectedFilter.value,
                  );

                  if (filteredNews.isEmpty) {
                    return Center(
                      child: Text(
                        _getEmptyMessage(context, selectedFilter.value),
                        style: const TextStyle(color: ColorConstants.tertiary),
                      ),
                    );
                  }
                  return ScrollToHideNavbar(
                    controller: ScrollController(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: filteredNews
                            .map((news) => AdminEventCard(news: news))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFilterName(BuildContext context, NewsFilterType filter) {
    final localizeWithContext = AppLocalizations.of(context)!;
    switch (filter) {
      case NewsFilterType.all:
        return localizeWithContext.feedFilterAll;
      case NewsFilterType.pending:
        return localizeWithContext.feedFilterPending;
      case NewsFilterType.approved:
        return localizeWithContext.feedFilterApproved;
      case NewsFilterType.rejected:
        return localizeWithContext.feedFilterRejected;
    }
  }

  List<News> _getFilteredNews(List<News> allNews, NewsFilterType filter) {
    switch (filter) {
      case NewsFilterType.all:
        return allNews;
      case NewsFilterType.pending:
        return allNews
            .where((news) => news.status == NewsStatus.waitingApproval)
            .toList();
      case NewsFilterType.approved:
        return allNews
            .where((news) => news.status == NewsStatus.published)
            .toList();
      case NewsFilterType.rejected:
        return allNews
            .where((news) => news.status == NewsStatus.rejected)
            .toList();
    }
  }

  String _getEmptyMessage(BuildContext context, NewsFilterType filter) {
    final localizeWithContext = AppLocalizations.of(context)!;
    switch (filter) {
      case NewsFilterType.all:
        return localizeWithContext.feedEmptyAll;
      case NewsFilterType.pending:
        return localizeWithContext.feedEmptyPending;
      case NewsFilterType.approved:
        return localizeWithContext.feedEmptyApproved;
      case NewsFilterType.rejected:
        return localizeWithContext.feedEmptyRejected;
    }
  }
}
