import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/ui/pages/admin_page/announcer_bar.dart';
import 'package:myecl/advert/ui/pages/main_page/advert_card.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final selected = ref.watch(announcerProvider);
    return Column(
      children: [
        const AnnouncerBar(),
        SizedBox(
          height: MediaQuery.of(context).size.height - 165.4,
          child: IntrinsicHeight(
            
            child: Refresher(
                onRefresh: () async {
                  await advertListNotifier.loadAdverts();
                },
                child: advertList.when(
                  data: (data) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ...data
                            .map((advert) => selected.where((e)=>advert.groups.contains(e.name)).isNotEmpty || selected.isEmpty ? AdvertCard(
                                onTap: () {
                                  print(selected);
                                  advertNotifier.setAdvert(advert);
                                  pageNotifier
                                      .setAdvertPage(AdvertPage.detailFromMainPage);
                                },
                                advert: advert):Container()
                                )
                            .toList(),
                      ],
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  },
                ),
              ),
          ),
        ),
      ],
    );
  }
}