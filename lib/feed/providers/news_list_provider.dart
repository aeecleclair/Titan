import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/repositories/news_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class NewsListNotifier extends ListNotifier<News> {
  final NewsRepository newsRepository;
  NewsListNotifier({required this.newsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<News>>> loadNewsList() async {
    return await loadList(newsRepository.getPublishedNews);
  }
}

final newsListProvider =
    StateNotifierProvider<NewsListNotifier, AsyncValue<List<News>>>((ref) {
      final token = ref.watch(tokenProvider);
      final newsRepository = NewsRepository()..setToken(token);
      NewsListNotifier newsListNotifier = NewsListNotifier(
        newsRepository: newsRepository,
      );
      return newsListNotifier;
    });
