import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/feed/providers/news_list_provider.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class FeedTemplate extends ConsumerWidget {
  final Widget child;
  const FeedTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(
              root: FeedRouter.root,
              onBack: () {
                if (QR.currentPath ==
                    FeedRouter.root + FeedRouter.eventHandling) {
                  final newsListNotifier = ref.watch(newsListProvider.notifier);
                  newsListNotifier.loadNewsList();
                }
              },
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
