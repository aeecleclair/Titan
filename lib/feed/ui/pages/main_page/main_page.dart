import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/feed_item.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/main_page/feed_timeline.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class FeedMainPage extends HookConsumerWidget {
  const FeedMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedItems = useState<List<FeedItem>>(FeedItem.getFakeItems());
    final filteredItems = useState<List<FeedItem>>(feedItems.value);

    return FeedTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            CustomSearchBar(onFilter: () {}, onSearch: (_) {}),

            const SizedBox(height: 20),

            // Title
            const Text(
              "Actualité",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),

            const SizedBox(height: 20),

            // // Timeline
            SizedBox(
              height: MediaQuery.of(context).size.height - 190,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FeedTimeline(
                  items: filteredItems.value,
                  onItemTap: (item) {
                    // TODO: Handle item tap
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Event tapped: ${item.title}')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
