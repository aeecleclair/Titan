import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/feed/tools/image_color_utils.dart' as image_color_utils;

// Provider for managing dominant color state
final dominantColorProvider =
    AsyncNotifierProvider.family<DominantColorNotifier, Color?, ImageProvider?>(
      DominantColorNotifier.new,
    );

class DominantColorNotifier extends AsyncNotifier<Color?> {
  DominantColorNotifier(this.imageProvider);

  final ImageProvider? imageProvider;

  @override
  Future<Color?> build() async {
    return await _analyzeDominantColor(imageProvider);
  }

  Future<Color?> _analyzeDominantColor(ImageProvider? imageProvider) async {
    if (imageProvider == null) {
      return null;
    }

    try {
      final color = await image_color_utils.getDominantColor(imageProvider);
      return color;
    } catch (error) {
      rethrow;
    }
  }

  void refresh() async {
    state = const AsyncValue.loading();
    try {
      final color = await _analyzeDominantColor(imageProvider);
      state = AsyncValue.data(color);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

class AdaptiveTextCard extends HookConsumerWidget {
  final Widget child;
  final bool hasImage;
  final ImageProvider? imageProvider;

  const AdaptiveTextCard({
    super.key,
    required this.child,
    required this.hasImage,
    this.imageProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use a memoized provider key to avoid unnecessary provider rebuilds
    final providerKey = useMemoized(() => imageProvider, [imageProvider]);

    // Watch the dominant color state
    final dominantColorState = ref.watch(dominantColorProvider(providerKey));

    return AdaptiveTextProvider(
      isAnalyzing: dominantColorState.isLoading,
      hasImage: hasImage,
      child: child,
    );
  }
}

class AdaptiveTextProvider extends InheritedWidget {
  final bool isAnalyzing;
  final bool hasImage;

  const AdaptiveTextProvider({
    super.key,
    required this.isAnalyzing,
    required this.hasImage,
    required super.child,
  });

  static AdaptiveTextProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveTextProvider>();
  }

  @override
  bool updateShouldNotify(AdaptiveTextProvider oldWidget) {
    return isAnalyzing != oldWidget.isAnalyzing ||
        hasImage != oldWidget.hasImage;
  }
}
