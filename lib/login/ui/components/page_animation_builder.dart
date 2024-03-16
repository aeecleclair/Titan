import 'package:flutter/material.dart';
import 'package:myecl/login/ui/components/background_painter.dart';

class PageAnimationBuilder extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  const PageAnimationBuilder({
    super.key,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: animation,
              ),
            ),
          ),
          SafeArea(
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
