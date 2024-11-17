import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/Sg/providers/Sg_list_provider.dart';
import 'package:myecl/sg/providers/is_sg_admin_provider.dart';
import 'package:myecl/sg/router.dart';
import 'package:myecl/sg/sg.dart';
import 'package:myecl/sg/ui/pages/sg_list.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

/// Page principale du calendrier
class SgMainPage extends ConsumerWidget {
  const SgMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isShotgunAdminProvider);
    final sgListNotifier = ref.watch(sgListProvider.notifier);
    return SgTemplate(
      child: ColumnRefresher(
        onRefresh: () => sgListNotifier.loadSgList(),
        children: [
          if (isAdmin)
            const SizedBox(
              height: 20,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 116.7,
                child: AdminButton(
                  onTap: () {
                    QR.to(ShotgunRouter.root + ShotgunRouter.admin);
                  },
                ),
              ),
            ],
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(child: SgList()),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
