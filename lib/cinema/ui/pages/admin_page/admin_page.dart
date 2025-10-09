import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';
import 'package:titan/cinema/providers/session_provider.dart';
import 'package:titan/cinema/router.dart';
import 'package:titan/cinema/tools/constants.dart';
import 'package:titan/cinema/ui/cinema.dart';
import 'package:titan/cinema/ui/pages/admin_page/admin_session_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionNotifier = ref.read(sessionProvider.notifier);
    final sessionList = ref.watch(sessionListProvider);
    final sessionListNotifier = ref.read(sessionListProvider.notifier);
    return CinemaTemplate(
      child: AsyncChild(
        value: sessionList,
        builder: (context, data) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  sessionNotifier.setSession(Session.empty());
                  QR.to(
                    CinemaRouter.root +
                        CinemaRouter.admin +
                        CinemaRouter.addEdit,
                  );
                },
                child: const CardLayout(
                  width: 155,
                  height: 300,
                  margin: EdgeInsets.all(8),
                  child: Center(child: HeroIcon(HeroIcons.plus, size: 50)),
                ),
              ),
              ...data.map(
                (session) => AdminSessionCard(
                  session: session,
                  onEdit: () {
                    sessionNotifier.setSession(session);
                    QR.to(
                      CinemaRouter.root +
                          CinemaRouter.admin +
                          CinemaRouter.addEdit,
                    );
                  },
                  onDelete: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogBox(
                          title: CinemaTextConstants.deleting,
                          descriptions: CinemaTextConstants.deleteSession,
                          onYes: () {
                            sessionListNotifier.deleteSession(session);
                          },
                        );
                      },
                    );
                  },
                  onTap: () {
                    sessionNotifier.setSession(session);
                    QR.to(CinemaRouter.root + CinemaRouter.detail);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
