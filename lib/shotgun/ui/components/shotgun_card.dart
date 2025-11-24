import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/ui/components/shotgun_countdown.dart';

class ShotgunCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final Shotgun shotgun;

  const ShotgunCard({super.key, required this.onTap, required this.shotgun});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 300;
    double height = 300;

    final isWebFormat = ref.watch(isWebFormatProvider);
    final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));

    return GestureDetector(
      onTap: () {
        if (!isWebFormat) {
          onTap();
        }
      },
      child: Container(
        width: 46,
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(50),
        color: Color.fromARGB(210, 146, 172, 194),
        child: Column(
          children: [
            AutoSizeText(shotgun.title),
            ShotgunCountdown(duration: fifteenAgo),
          ],
        ),
      ),
    );
  }
}
