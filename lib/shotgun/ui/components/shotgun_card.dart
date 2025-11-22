import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/shotgun/class/shotgun.dart';

class ShotgunCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final Shotgun shotgun;

  const ShotgunCard({super.key, required this.onTap, required this.shotgun});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 300;
    double height = 300;

    return Container(child: Text(shotgun.title));
  }
}
