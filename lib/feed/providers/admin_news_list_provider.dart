import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AdminNewsListNotifier extends ListNotifierAPI<News> {
  Openapi get newsRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<News>> build() {
    loadNewsList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<News>>> loadNewsList() async {
    return await loadList(newsRepository.feedAdminNewsGet);
  }

  Future<bool> approveNews(News news) async {
    return await update(
      () => newsRepository.feedAdminNewsNewsIdApprovePost(newsId: news.id),
      (news) => news.id,
      news,
    );
  }

  Future<bool> rejectNews(News news) async {
    return await update(
      () => newsRepository.feedAdminNewsNewsIdRejectPost(newsId: news.id),
      (news) => news.id,
      news,
    );
  }
}

final adminNewsListProvider =
    NotifierProvider<AdminNewsListNotifier, AsyncValue<List<News>>>(
      AdminNewsListNotifier.new,
    );
