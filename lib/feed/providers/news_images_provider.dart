import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class NewsImagesNotifier extends MapNotifier<String, Image> {}

final newsImagesProvider =
    NotifierProvider<NewsImagesNotifier, Map<String, AsyncValue<List<Image>>?>>(
      () => NewsImagesNotifier(),
    );
