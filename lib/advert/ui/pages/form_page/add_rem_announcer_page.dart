import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/advert/class/announcer.dart';
import 'package:titan/advert/providers/all_announcer_list_provider.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/advert/tools/constants.dart';
import 'package:titan/advert/ui/pages/advert.dart';
import 'package:titan/advert/ui/pages/form_page/announcer_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class AddRemAnnouncerPage extends HookConsumerWidget {
  const AddRemAnnouncerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcerListNotifier = ref.watch(announcerListProvider.notifier);
    final announcers = ref.watch(allAnnouncerList);
    final groups = ref.watch(allGroupListProvider);
    final announcerIds = announcers.map((x) => x.groupManagerId).toList();

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
                    const SizedBox(height: 30),
                    AsyncChild(
                      value: groups,
                      builder: (context, groupList) {
                        final canAdd = groupList
                            .where((x) => !announcerIds.contains(x.id))
                            .toList();
                        final canRemove = groupList
                            .where((x) => announcerIds.contains(x.id))
                            .toList();
                        return (canAdd + canRemove).isNotEmpty
                            ? Column(
                                children:
                                    canAdd
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              Announcer newAnnouncer =
                                                  Announcer(
                                                    groupManagerId: e.id,
                                                    id: '',
                                                    name: e.name,
                                                  );
                                              tokenExpireWrapper(ref, () async {
                                                final value =
                                                    await announcerListNotifier
                                                        .addAnnouncer(
                                                          newAnnouncer,
                                                        );
                                                if (value) {
                                                  displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AdvertTextConstants
                                                        .addedAnnouncer,
                                                  );
                                                } else {
                                                  displayToastWithContext(
                                                    TypeMsg.error,
                                                    AdvertTextConstants
                                                        .addingError,
                                                  );
                                                }
                                                announcerListNotifier
                                                    .loadAllAnnouncerList();
                                              });
                                            },
                                            child: AnnouncerCard(
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
                                                            .deleteAnnouncer,
                                                    onYes: () {
                                                      tokenExpireWrapper(ref, () async {
                                                        final value = await announcerListNotifier
                                                            .deleteAnnouncer(
                                                              announcers
                                                                  .where(
                                                                    (element) =>
                                                                        e.id ==
                                                                        e.id,
                                                                  )
                                                                  .toList()[0],
                                                            );
                                                        if (value) {
                                                          displayToastWithContext(
                                                            TypeMsg.msg,
                                                            AdvertTextConstants
                                                                .removedAnnouncer,
                                                          );
                                                        } else {
                                                          displayToastWithContext(
                                                            TypeMsg.error,
                                                            AdvertTextConstants
                                                                .removingError,
                                                          );
                                                        }
                                                        announcerListNotifier
                                                            .loadAllAnnouncerList();
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: AnnouncerCard(
                                              e: e,
                                              icon: HeroIcons.minus,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              )
                            : const Center(
                                child: Text(
                                  AdvertTextConstants.noMoreAnnouncer,
                                ),
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
