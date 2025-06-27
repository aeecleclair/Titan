import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isWebFormatProvider = Provider((ref) {
  final window = WidgetsBinding.instance.platformDispatcher.views.first;
  var pixelRatio = window.devicePixelRatio;
  var logicalScreenSize = window.physicalSize / pixelRatio;
  var logicalWidth = logicalScreenSize.width;
  var paddingLeft = window.padding.left / window.devicePixelRatio;
  var paddingRight = window.padding.right / window.devicePixelRatio;
  var safeWidth = logicalWidth - paddingLeft - paddingRight;
  return safeWidth > 500;
});
