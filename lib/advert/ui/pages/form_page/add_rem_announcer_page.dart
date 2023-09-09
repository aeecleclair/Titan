import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/advert/providers/all_announcer_list_provider.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class AddRemAnnouncerPage extends HookConsumerWidget {
  const AddRemAnnouncerPage({Key? key}) : super(key: key);

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
                    child: Column(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AdvertTextConstants.modifyAnnouncingGroup,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.gradient1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  groups.when(data: (groupList) {
                    final canAdd = groupList
                        .where((x) => !announcerIds.contains(x.id))
                        .toList();
                    final canRemove = groupList
                        .where((x) => announcerIds.contains(x.id))
                        .toList();
                    return (canAdd + canRemove).isNotEmpty
                        ? Column(
                            children: canAdd
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            Announcer newAnnouncer = Announcer(
                                                groupManagerId: e.id,
                                                id: '',
                                                name: e.name);
                                            tokenExpireWrapper(ref, () async {
                                              final value =
                                                  await announcerListNotifier
                                                      .addAnnouncer(
                                                          newAnnouncer);
                                              if (value) {
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AdvertTextConstants
                                                        .addedAnnouncer);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    AdvertTextConstants
                                                        .addingError);
                                              }
                                              announcerListNotifier
                                                  .loadAllAnnouncerList();
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e.name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const HeroIcon(HeroIcons.plus,
                                                    size: 25,
                                                    color: Colors.black)
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList() +
                                canRemove
                                    .map((e) => GestureDetector(
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
                                                      tokenExpireWrapper(ref,
                                                          () async {
                                                        final value =
                                                            await announcerListNotifier
                                                                .deleteAnnouncer(
                                                                    announcers
                                                                        .where(
                                                                          (element) =>
                                                                              e.id ==
                                                                              e.id,
                                                                        )
                                                                        .toList()[0]);
                                                        if (value) {
                                                          displayToastWithContext(
                                                              TypeMsg.msg,
                                                              AdvertTextConstants
                                                                  .removedAnnouncer);
                                                        } else {
                                                          displayToastWithContext(
                                                              TypeMsg.error,
                                                              AdvertTextConstants
                                                                  .removingError);
                                                        }
                                                        announcerListNotifier
                                                            .loadAllAnnouncerList();
                                                      });
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e.name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const HeroIcon(HeroIcons.minus,
                                                    size: 25,
                                                    color: Colors.black)
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList())
                        : const Center(
                            child: Text(AdvertTextConstants.noMoreAnnouncer));
                  }, error: (Object error, StackTrace? stackTrace) {
                    return Text(error.toString());
                  }, loading: () {
                    return const Center(child: CircularProgressIndicator());
                  })
                ]))
              ],
            ),
          )),
    );
  }
}
