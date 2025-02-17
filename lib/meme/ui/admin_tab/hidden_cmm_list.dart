import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/hidden_meme_list_provider.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/ui/components/meme_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({super.parent});

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50,
        stiffness: 500,
        damping: 1,
      );
}

class HiddenMemeList extends ConsumerWidget {
  const HiddenMemeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiddenMemeList = ref.watch(hiddenMemeListProvider);

    return AsyncChild(
      value: hiddenMemeList,
      builder: (context, memeList) => PageView.builder(
        scrollDirection: Axis.vertical,
        physics: const CustomPageViewScrollPhysics(),
        controller: PageController(),
        itemCount: memeList.length,
        itemBuilder: (context, index) {
          final meme = memeList[index];
          return FutureBuilder<Uint8List>(
            future: ref.read(memeListProvider.notifier).getMemeImage(meme.id),
            builder: (context, imageSnapshot) {
              if (!imageSnapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return MemeCard(
                meme: meme,
                image: imageSnapshot.data!,
                page: PageType.hidden,
              );
            },
          );
        },
      ),
    );
  }
}
