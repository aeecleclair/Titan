import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/feed/tools/image_color_utils.dart' as ImageColorUtils;

// Provider for managing dominant color state
final dominantColorProvider =
    StateNotifierProvider.family<
      DominantColorNotifier,
      AsyncValue<Color?>,
      ImageProvider?
    >((ref, imageProvider) => DominantColorNotifier(imageProvider));

class DominantColorNotifier extends StateNotifier<AsyncValue<Color?>> {
  final ImageProvider? imageProvider;

  DominantColorNotifier(this.imageProvider)
    : super(const AsyncValue.loading()) {
    _analyzeDominantColor();
  }

  Future<void> _analyzeDominantColor() async {
    if (imageProvider == null) {
      state = const AsyncValue.data(null);
      return;
    }

    try {
      state = const AsyncValue.loading();
      final color = await ImageColorUtils.getDominantColor(imageProvider!);
      state = AsyncValue.data(color);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void refresh() {
    _analyzeDominantColor();
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
