import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/advert/providers/all_advertiser_list_provider.dart';
import 'package:myecl/advert/providers/advertiser_list_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/ui/pages/form_page/advertiser_card.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class AddDeleteAdvertiserPage extends HookConsumerWidget {
  const AddDeleteAdvertiserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertiserListNotifier = ref.watch(advertiserListProvider.notifier);
    final advertisers = ref.watch(allAdvertiserList);
    final groups = ref.watch(allGroupListProvider);
    final advertiserIds = advertisers.map((x) => x.groupManagerId).toList();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdvertTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AdvertTextConstants.modifyAnnouncingGroup,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AsyncChild(
                      value: groups,
                      builder: (context, groupList) {
                        final canAdd = groupList
                            .where((x) => !advertiserIds.contains(x.id))
                            .toList();
                        final canRemove = groupList
                            .where((x) => advertiserIds.contains(x.id))
                            .toList();
                        return (canAdd + canRemove).isNotEmpty
                            ? Column(
                                children: canAdd
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () async {
                                              AdvertiserBase newAdvertiser =
                                                  AdvertiserBase(
                                                groupManagerId: e.id,
                                                name: e.name,
                                              );
                                              final value =
                                                  await advertiserListNotifier
                                                      .addAdvertiser(
                                                newAdvertiser,
                                              );
                                              if (value) {
                                                displayToastWithContext(
                                                  TypeMsg.msg,
                                                  AdvertTextConstants
                                                      .addedAdvertiser,
                                                );
                                              } else {
                                                displayToastWithContext(
                                                  TypeMsg.error,
                                                  AdvertTextConstants
                                                      .addingError,
                                                );
                                              }
                                              advertiserListNotifier
                                                  .loadAllAdvertiserList();
                                            },
                                            child: AdvertiserCard(
                                              e: e,
                                              icon: HeroIcons.plus,
                                            ),
                                          ),
                                        )
                                        .toList() +
                                    canRemove
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomDialogBox(
                                                    title: AdvertTextConstants
                                                        .deleting,
                                                    descriptions:
                                                        AdvertTextConstants
                                                            .deleteAdvertiser,
                                                    onYes: () async {
                                                      final value =
                                                          await advertiserListNotifier
                                                              .deleteAdvertiser(
                                                        advertisers
                                                            .where(
                                                              (element) =>
                                                                  e.id == e.id,
                                                            )
                                                            .toList()[0]
                                                            .id,
                                                      );
                                                      if (value) {
                                                        displayToastWithContext(
                                                          TypeMsg.msg,
                                                          AdvertTextConstants
                                                              .removedAdvertiser,
                                                        );
                                                      } else {
                                                        displayToastWithContext(
                                                          TypeMsg.error,
                                                          AdvertTextConstants
                                                              .removingError,
                                                        );
                                                      }
                                                      advertiserListNotifier
                                                          .loadAllAdvertiserList();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: AdvertiserCard(
                                              e: e,
                                              icon: HeroIcons.minus,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              )
                            : const Center(
                                child:
                                    Text(AdvertTextConstants.noMoreAdvertiser),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
