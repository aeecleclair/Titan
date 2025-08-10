import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/news_list_provider.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/main_page/feed_timeline.dart';
import 'package:titan/feed/ui/pages/main_page/filter_news.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class FeedMainPage extends HookConsumerWidget {
  const FeedMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsListProvider);
    final isSuperAdmin = ref.watch(isAdminProvider);
    final scrollController = useScrollController();

    return FeedTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onFilter: () async {
                final syncNews = news.maybeWhen(
                  orElse: () => <News>[],
                  data: (loaded) => loaded,
                );
                final entities = syncNews.map((e) => e.entity).toSet().toList();
                final modules = syncNews.map((e) => e.module).toSet().toList();
                await showCustomBottomModal(
                  modal: FilterNewsModal(entities: entities, modules: modules),
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
                if (isSuperAdmin)
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
                                  Navigator.of(context).pop();
                                  QR.to(FeedRouter.root + FeedRouter.addEvent);
                                },
                              ),
                              const SizedBox(height: 20),
                              Button(
                                text: 'Demandes de publication',
                                onPressed: () {
                                  Navigator.of(context).pop();
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

            Expanded(
              child: ScrollToHideNavbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: AsyncChild(
                    value: news,
                    builder: (context, news) => news.isEmpty
                        ? const Center(
                            child: Text(
                              'Aucune actualité disponible',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.tertiary,
                              ),
                            ),
                          )
                        : FeedTimeline(
                            isAdmin: isAdmin,
                            items: news,
                            onItemTap: (item) {},
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
