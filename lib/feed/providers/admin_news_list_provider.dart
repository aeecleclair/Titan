import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/repositories/news_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class AdminNewsListNotifier extends ListNotifier<News> {
  final NewsRepository newsRepository;
  AdminNewsListNotifier({required this.newsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<News>>> loadNewsList() async {
    return await loadList(newsRepository.getAllNews);
  }

  Future<bool> addNews(News news) async {
    return await add(newsRepository.createNews, news);
  }

  Future<bool> approveNews(News news) async {
    return await update(
      (news) => newsRepository.approveNews(news.id),
      (newsList, news) =>
          newsList..[newsList.indexWhere((d) => d.id == news.id)] = news,
      news,
    );
  }

  Future<bool> rejectNews(News news) async {
    return await update(
      (news) => newsRepository.rejectNews(news.id),
      (newsList, news) =>
          newsList..[newsList.indexWhere((d) => d.id == news.id)] = news,
      news,
    );
  }
}

final adminNewsListProvider =
    StateNotifierProvider<AdminNewsListNotifier, AsyncValue<List<News>>>((ref) {
      final token = ref.watch(tokenProvider);
      final newsRepository = NewsRepository()..setToken(token);
      AdminNewsListNotifier newsListNotifier = AdminNewsListNotifier(
        newsRepository: newsRepository,
      );
      return newsListNotifier;
    });
