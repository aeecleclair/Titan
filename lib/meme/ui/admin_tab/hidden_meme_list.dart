import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/hidden_meme_list_provider.dart';
import 'package:myecl/meme/ui/components/meme_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class HiddenMemeList extends ConsumerWidget {
  const HiddenMemeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiddenMemeListNotifier = ref.watch(hiddenMemeListProvider.notifier);
    final hiddenMemeList = ref.watch(hiddenMemeListProvider);
    return AsyncChild(
      value: hiddenMemeList,
      builder: (context, hiddenMemeList) {
        print(hiddenMemeList);
        return Refresher(
          onRefresh: () => hiddenMemeListNotifier.getHiddenMeme(),
          child: Column(
            children: [
              ...hiddenMemeList.map((meme) {
                return FutureBuilder<Uint8List>(
                  future: hiddenMemeListNotifier.getMemeImage(meme.id),
                  builder: (context, imageSnapshot) {
                    if (!imageSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MemeCard(
                      memeId: meme.id,
                      image: imageSnapshot.data!,
                      page: PageType.hidden,
                    );
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
