import 'package:flutter/material.dart';

class MessageBorder extends ShapeBorder {
  final bool usePadding;

  const MessageBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
      rect.topLeft,
      rect.bottomRight - const Offset(0, 20),
    );
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)))
      ..moveTo(rect.bottomCenter.dx - 15, rect.bottomCenter.dy)
      ..relativeLineTo(15, 20)
      ..relativeLineTo(15, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
