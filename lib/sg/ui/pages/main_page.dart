import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/sg/providers/is_sg_admin_provider.dart';
import 'package:myecl/sg/router.dart';
import 'package:myecl/sg/sg.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

/// Page principale du calendrier
class ShotgunMainPage extends ConsumerWidget {
  const ShotgunMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isShotgunAdminProvider);
    return SgTemplate(
        child: Column(
      children: [
        if (isAdmin)
          SizedBox(
            width: 116.7,
            child: AdminButton(
              onTap: () {
                QR.to(ShotgunRouter.root + ShotgunRouter.admin);
              },
            ),
          ),
      ],
    ));
  }
}
