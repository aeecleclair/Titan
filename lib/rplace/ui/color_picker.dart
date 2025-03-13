import 'package:flutter/material.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'package:myecl/rplace/providers/pixelinfo_providers.dart';
import 'package:myecl/rplace/providers/pixels_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;

final listeCouleurs = [
  'FFffffff',
  'FFf44336',
  'FF000000',
  'FF2196f3',
  'FF9c27b0',
  'FF4caf50',
  'FFe91e63',
  'FF536dfe',
  'FF009688',
  'FFffc107',
];

class ColBouton extends HookConsumerWidget {
  final int x;
  final int y;
  final String color;

  const ColBouton({
    super.key,
    required this.x,
    required this.y,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pixelListNotifier = ref.read(pixelListProvider.notifier);

    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(borderRadius: null),
      child: FilledButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(int.parse(color, radix: 16)),
        ),
        onPressed: () => {
          pixelListNotifier.createPixel(
            Pixel(
              x: x,
              y: y,
              color: color,
            ),
          ),
          Navigator.pop(context),
        },
        child: null,
      ),
    );
  }
}

class ColorPicker extends HookConsumerWidget {
  final int x;
  final int y;

  const ColorPicker({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pixelinfo_value = ref.watch(pixelInfoProvider);

    timeago.setLocaleMessages('fr', timeago.FrMessages());

    return SizedBox(
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AsyncChild(
              value: pixelinfo_value,
              builder: (context, pixelinfo_value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        AutoSizeText(
                          pixelinfo_value.user.nickname ??
                              ("${pixelinfo_value.user.firstname} ${pixelinfo_value.user.name}"),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      timeago.format(pixelinfo_value.date, locale: 'fr'),
                    ),
                  ],
                );
              }),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: listeCouleurs
                    .map(
                      (colo) => ColBouton(
                        x: x,
                        y: y,
                        color: colo,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
