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
import 'package:qlevar_router/qlevar_router.dart';

class AddRemAnnouncerPage extends HookConsumerWidget {
  const AddRemAnnouncerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcerListNotifier = ref.watch(announcerListProvider.notifier);
    final announcers = ref.watch(allAnnouncerList);
    final associations = ref.watch(allGroupListProvider);
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
                    child: Text(AdvertTextConstants.modifyAnnouncingAssociation,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.gradient1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  associations.when(data: (associationList) {
                    final canAdd = associationList
                        .where((x) => !announcerIds.contains(x.id))
                        .toList();
                    final canRem = associationList
                        .where((x) => announcerIds.contains(x.id))
                        .toList();
                    return (canAdd + canRem).isNotEmpty
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
                                                      .addAnnouncer(newAnnouncer);
                                              if (value) {
                                                QR.back();
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
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  e.name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const HeroIcon(HeroIcons.plus,
                                                    size: 25, color: Colors.black)
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList() +
                                canRem
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            tokenExpireWrapper(ref, () async {
                                              final value =
                                                  await announcerListNotifier
                                                      .deleteAnnouncer(announcers
                                                          .where(
                                                            (element) =>
                                                                e.id == e.id,
                                                          )
                                                          .toList()[0]);
                                              if (value) {
                                                QR.back();
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
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  e.name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const HeroIcon(HeroIcons.minus,
                                                    size: 25, color: Colors.black)
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
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ));
                  })
                ]))
              ],
            ),
          )),
    );
  }
}
