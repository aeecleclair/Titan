import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/providers/news_images_provider.dart';
import 'package:titan/feed/repositories/news_image_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class NewsImageNotifier extends SingleNotifier<Image> {
  NewsImageRepository get newsImageRepository =>
      ref.watch(newsImageRepositoryProvider);

  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  NewsImagesNotifier get newsImagesNotifier =>
      ref.watch(newsImagesProvider.notifier);

  Future<Image> getNewsImage(String id) async {
    final image = await newsImageRepository.getNewsImage(id);
    newsImagesNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final newsImageProvider =
    NotifierProvider<NewsImageNotifier, AsyncValue<Image>>(
      NewsImageNotifier.new,
    );
