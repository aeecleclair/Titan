import 'package:flutter/material.dart';

class VerticalClipScroll extends StatelessWidget {
  final Widget child;

  const VerticalClipScroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _VerticalOnlyClipper(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        child: Align(alignment: Alignment.topCenter, child: child),
      ),
    );
  }
}

class _VerticalOnlyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const big = 1000000.0;
    return Path()
      ..addRect(Rect.fromLTRB(-big, 0.0, size.width + big, size.height));
  }

  @override
  bool shouldReclip(covariant _VerticalOnlyClipper oldClipper) => false;
}
