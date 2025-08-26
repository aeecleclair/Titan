import 'package:flutter/material.dart';
import 'package:titan/feed/tools/image_color_utils.dart' as ImageColorUtils;
import 'package:titan/tools/constants.dart';

class AdaptiveTextCard extends StatefulWidget {
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
  State<AdaptiveTextCard> createState() => _AdaptiveTextCardState();
}

class _AdaptiveTextCardState extends State<AdaptiveTextCard> {
  Color? _dominantColor;
  bool _isAnalyzing = true;

  @override
  void initState() {
    super.initState();
    if (widget.hasImage && widget.imageProvider != null) {
      _analyzeDominantColor();
    } else {
      _isAnalyzing = false;
    }
  }

  @override
  void didUpdateWidget(AdaptiveTextCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasImage != oldWidget.hasImage ||
        widget.imageProvider != oldWidget.imageProvider) {
      if (widget.hasImage && widget.imageProvider != null) {
        _analyzeDominantColor();
      } else {
        setState(() {
          _isAnalyzing = false;
          _dominantColor = null;
        });
      }
    }
  }

  Future<void> _analyzeDominantColor() async {
    if (widget.imageProvider == null) return;

    try {
      final color = await ImageColorUtils.getDominantColor(
        widget.imageProvider!,
      );
      if (mounted) {
        setState(() {
          _dominantColor = color;
          _isAnalyzing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTextProvider(
      isAnalyzing: _isAnalyzing,
      dominantColor: _dominantColor,
      hasImage: widget.hasImage,
      child: widget.child,
    );
  }
}

class AdaptiveTextProvider extends InheritedWidget {
  final bool isAnalyzing;
  final Color? dominantColor;
  final bool hasImage;

  const AdaptiveTextProvider({
    super.key,
    required this.isAnalyzing,
    required this.dominantColor,
    required this.hasImage,
    required super.child,
  });

  static AdaptiveTextProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveTextProvider>();
  }

  Color getTextColor() {
    if (!hasImage || isAnalyzing || dominantColor == null) {
      return ColorConstants.background; // Default white text
    }
    return ImageColorUtils.getTextColor(dominantColor!);
  }

  @override
  bool updateShouldNotify(AdaptiveTextProvider oldWidget) {
    return isAnalyzing != oldWidget.isAnalyzing ||
        dominantColor != oldWidget.dominantColor ||
        hasImage != oldWidget.hasImage;
  }
}
