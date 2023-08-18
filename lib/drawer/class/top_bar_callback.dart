import 'package:flutter/material.dart';

class TopBarCallback {
  final String moduleRoot;
  final VoidCallback? onMenu;
  final VoidCallback? onBack;

  TopBarCallback({this.onMenu, this.onBack, required this.moduleRoot});
}