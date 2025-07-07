import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/feed/class/feed_item.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/main_page/feed_timeline.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class FeedMainPage extends HookConsumerWidget {
  const FeedMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedItems = useState<List<FeedItem>>(FeedItem.getFakeItems());
    final filteredItems = useState<List<FeedItem>>(feedItems.value);
    final isAdmin = ref.watch(isAdminProvider);

    return FeedTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onFilter: () async {
                await showCustomBottomModal(
                  modal: BottomModalTemplate(
                    title: 'Filtrer',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Groupes d\'association'),
                        SizedBox(height: 10),
                        HorizontalListView(
                          height: 50,
                          children: [
                            ItemChip(child: Text('Option 1')),
                            ItemChip(child: Text('Option 2')),
                            ItemChip(child: Text('Option 3')),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text('Associations'),
                        SizedBox(height: 10),
                        HorizontalListView(
                          height: 50,
                          children: [
                            ItemChip(child: Text('Association 1')),
                            ItemChip(child: Text('Association 2')),
                            ItemChip(child: Text('Association 3')),
                          ],
                        ),
                        SizedBox(height: 40),
                        Button(
                          text: 'Appliquer',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  context: context,
                  ref: ref,
                );
              },
              onSearch: (_) {},
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Actualité",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
                if (isAdmin)
                  CustomIconButton(
                    icon: HeroIcon(
                      HeroIcons.userGroup,
                      color: ColorConstants.background,
                    ),
                    onPressed: () {
                      showCustomBottomModal(
                        modal: BottomModalTemplate(
                          title: 'Administration',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Button(
                                text: 'Créer un événement',
                                onPressed: () {
                                  QR.to(FeedRouter.root + FeedRouter.addEvent);
                                },
                              ),
                              const SizedBox(height: 20),
                              Button(
                                text: 'Demandes de publication',
                                onPressed: () {
                                  QR.to(
                                    FeedRouter.root + FeedRouter.eventHandling,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        context: context,
                        ref: ref,
                      );
                    },
                  ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: MediaQuery.of(context).size.height - 193,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FeedTimeline(
                  items: filteredItems.value,
                  onItemTap: (item) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
