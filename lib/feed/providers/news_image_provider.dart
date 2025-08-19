import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/providers/news_images_provider.dart';
import 'package:titan/feed/repositories/news_image_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class NewsImageNotifier extends SingleNotifier<Image> {
  final newsImageRepository = NewsImageRepository();
  final NewsImagesNotifier newsImagesNotifier;
  NewsImageNotifier({required String token, required this.newsImagesNotifier})
    : super(const AsyncValue.loading()) {
    newsImageRepository.setToken(token);
  }

  Future<Image> getNewsImage(String id) async {
    final image = await newsImageRepository.getNewsImage(id);
    newsImagesNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateNewsImage(String id, Uint8List bytes) async {
    newsImagesNotifier.setTData(id, const AsyncLoading());
    final image = await newsImageRepository.addNewsImage(bytes, id);
    newsImagesNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final newsImageProvider =
    StateNotifierProvider<NewsImageNotifier, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      final newsImagesNotifier = ref.watch(newsImagesProvider.notifier);
      return NewsImageNotifier(
        token: token,
        newsImagesNotifier: newsImagesNotifier,
      );
    });
