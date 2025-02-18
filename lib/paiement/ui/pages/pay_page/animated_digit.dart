import 'package:flutter/widgets.dart';

class SingleValueFlipCounter extends StatelessWidget {
  final String value;
  final Duration duration = const Duration(milliseconds: 300);
  final Curve curve = Curves.linear;
  final TextStyle style;
  final Color color;
  final EdgeInsets padding = EdgeInsets.zero;
  final bool visible;

  const SingleValueFlipCounter({
    super.key,
    required this.value,
    // required this.duration,
    // required this.curve,
    required this.style,
    required this.color,
    // required this.padding,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = TextPainter(
      text: TextSpan(text: '0', style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    return TweenAnimationBuilder(
      tween: Tween(end: value),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        final opacity = visible ? 1.0 : 0.0;
        return Stack(
          children: [
            _buildSingleValue(
              value: value,
              offset: size.height,
              opacity: opacity,
            ),
            _buildSingleValue(
              value: value,
              offset: 0,
              opacity: 1 - opacity,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSingleValue({
    required String value,
    required double offset,
    required double opacity,
  }) {
    // Try to avoid using the `Opacity` widget when possible, for performance.
    final Widget child;
    if (color.a == 1) {
      // If the text style does not involve transparency, we can modify
      // the text color directly.
      child = Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: color.withValues(alpha: opacity.clamp(0, 1))),
      );
    } else {
      // Otherwise, we have to use the `Opacity` widget (less performant).
      child = Opacity(
        opacity: opacity.clamp(0, 1),
        child: Text(
          value,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Positioned(
      left: 0,
      right: 0,
      bottom: offset + padding.bottom,
      child: child,
    );
  }
}
