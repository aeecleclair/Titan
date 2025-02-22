import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/providers/my_meme_list_provider.dart';
import 'package:myecl/meme/router.dart';
import 'package:myecl/meme/ui/components/button.dart';
import 'package:myecl/meme/ui/components/meme_card.dart';
import 'package:myecl/meme/ui/components/sorting_type_bar.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MyMemeTab extends ConsumerWidget {
  const MyMemeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myMemeListNotifier = ref.watch(myMemeListProvider.notifier);
    final memeList = ref.watch(memeListProvider);
    return AsyncChild(
      value: memeList,
      builder: (context, memeList) {
        return Refresher(
          onRefresh: () => myMemeListNotifier.getMyMeme(),
          child: Column(
            children: [
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
                      page: PageType.myPost,
                    );
                  },
                );
              }),
              GestureDetector(
                onTap: () {
                  QR.to(MemeRouter.root + MemeRouter.add);
                },
                child: const MyButton(
                  text: MemeTextConstant.addMeme,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
