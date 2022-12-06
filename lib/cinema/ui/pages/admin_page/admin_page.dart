import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/ui/pages/admin_page/admin_session_card.dart';
import 'package:myecl/tools/dialog.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(cinemaPageProvider.notifier);
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final sessionList = ref.watch(sessionListProvider);
    final sessionListNotifier = ref.watch(sessionListProvider.notifier);
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: sessionList.when(
            data: (data) {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return GestureDetector(
                        onTap: () {
                          pageNotifier.setCinemaPage(CinemaPage.addSession);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                              child: HeroIcon(
                            HeroIcons.plus,
                            size: 50,
                          )),
                        ));
                  }
                  return AdminSessionCard(
                      session: data[index - 1],
                      onEdit: () {
                        sessionNotifier.setSession(data[index - 1]);
                        pageNotifier.setCinemaPage(CinemaPage.editSession);
                      },
                      onDelete: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialogBox(
                                title: CinemaTextConstants.deleting,
                                descriptions: CinemaTextConstants.deleteSession,
                                onYes: () {
                                  sessionListNotifier
                                      .deleteSession(data[index - 1]);
                                },
                              );
                            });
                      },
                      onTap: () {
                        sessionNotifier.setSession(data[index - 1]);
                        pageNotifier
                            .setCinemaPage(CinemaPage.detailFromAdminPage);
                      });
                },
              );
            },
            error: (Object error, StackTrace? stackTrace) {
              return Text('error $error');
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
