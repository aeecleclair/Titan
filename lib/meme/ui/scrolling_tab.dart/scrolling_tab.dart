import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/providers/sorting_bar_provider.dart';
import 'package:myecl/meme/ui/components/meme_card.dart';
import 'package:myecl/meme/ui/components/sorting_type_bar.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class ScrollingTab extends ConsumerWidget {
  const ScrollingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memeListNotifier = ref.watch(memeListProvider.notifier);
    final sortingType = ref.watch(selectedSortingTypeProvider);
    final memeList = ref.watch(memeListProvider);
    return AsyncChild(
      value: memeList,
      builder: (context, memeList) {
        return Refresher(
          onRefresh: () => memeListNotifier.getMeme(sortingType),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SortingTypeBar(),
              ),
              ...memeList.map((meme) {
                return FutureBuilder<Uint8List>(
                  future: ref
                      .watch(memeListProvider.notifier)
                      .getMemeImage(meme.id),
                  builder: (context, imageSnapshot) {
                    if (!imageSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MemeCard(
                      memeId: meme.id,
                      image: imageSnapshot.data!,
                      page: PageType.scrolling,
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
