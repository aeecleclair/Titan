import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/repositories/news_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class NewsListNotifier extends ListNotifier<News> {
  final NewsRepository newsRepository;
  AsyncValue<List<News>> allNews = const AsyncValue.loading();
  NewsListNotifier({required this.newsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<News>>> loadNewsList() async {
    return allNews = await loadList(newsRepository.getPublishedNews);
  }

  void filterNews(List<String> entities, List<String> modules) {
    state = AsyncValue.data(
      (allNews.value ?? []).where((news) {
        final matchesEntity =
            entities.isEmpty || entities.contains(news.entity);
        final matchesModule = modules.isEmpty || modules.contains(news.module);
        return matchesEntity && matchesModule;
      }).toList(),
    );
  }

  void resetFilters() {
    state = AsyncValue.data(allNews.value ?? []);
  }
}

final newsListProvider =
    StateNotifierProvider<NewsListNotifier, AsyncValue<List<News>>>((ref) {
      final token = ref.watch(tokenProvider);
      final newsRepository = NewsRepository()..setToken(token);
      NewsListNotifier newsListNotifier = NewsListNotifier(
        newsRepository: newsRepository,
      )..loadNewsList();
      return newsListNotifier;
    });
