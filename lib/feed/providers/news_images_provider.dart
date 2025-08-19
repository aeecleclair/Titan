import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class NewsImagesNotifier extends MapNotifier<String, Image> {
  NewsImagesNotifier() : super();
}

final newsImagesProvider =
    StateNotifierProvider<
      NewsImagesNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >((ref) {
      NewsImagesNotifier advertPosterNotifier = NewsImagesNotifier();
      return advertPosterNotifier;
    });
