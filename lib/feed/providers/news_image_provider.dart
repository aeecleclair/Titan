import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/repositories/news_image_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class NewsImageNotifier extends SingleNotifier<Uint8List> {
  final NewsImageRepository newsImageRepository;
  NewsImageNotifier({required this.newsImageRepository})
    : super(const AsyncLoading());

  Future<AsyncValue<Uint8List>> getNewsImage(String userId) async {
    return await load(
      () async => newsImageRepository.getNewsImage(userId),
    );
  }
}

final newsImageProvider =
    StateNotifierProvider<NewsImageNotifier, AsyncValue<Uint8List>>((ref) {
      final newsImageRepository = ref.watch(
        newsImageRepositoryProvider,
      );
      NewsImageNotifier notifier = NewsImageNotifier(
        newsImageRepository: newsImageRepository,
      );
      return notifier;
    });
