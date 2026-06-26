import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class NewsListNotifier extends ListNotifierAPI<News> {
  Openapi get newsRepository => ref.watch(repositoryProvider);
  AsyncValue<List<News>> allNews = const AsyncValue.loading();

  @override
  AsyncValue<List<News>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<News>>> loadNewsList() async {
    return allNews = await loadList(newsRepository.feedNewsGet);
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
    NotifierProvider<NewsListNotifier, AsyncValue<List<News>>>(
      NewsListNotifier.new,
    );
