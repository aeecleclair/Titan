import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class NewsImageRepository {
  final Openapi client;
  NewsImageRepository(this.client);

  Future<Image> getNewsImage(String id) async {
    final response = await client.feedNewsNewsIdImageGet(newsId: id);
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }
}

final newsImageRepositoryProvider = Provider<NewsImageRepository>(
  (ref) => NewsImageRepository(ref.watch(repositoryProvider)),
);
