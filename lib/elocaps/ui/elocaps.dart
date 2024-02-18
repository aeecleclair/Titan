import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ElocapsTemplate extends HookConsumerWidget {
  final Widget child;
  const ElocapsTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(playerHistoProvider);
    final displayBadge = history.maybeWhen(
        data: (games) => games.any((element) => !element.isConfirmed),
        orElse: () => false);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              TopBar(
                  title: ElocapsTextConstant.elocaps,
                  root: ElocapsRouter.root,
                  rightIcon: QR.currentPath == ElocapsRouter.root
                      ? GestureDetector(
                          onTap: () {
                            QR.to(ElocapsRouter.root + ElocapsRouter.history);
                          },
                          child: Center(
                              child: Badge(
                                  isLabelVisible: displayBadge,
                                  smallSize: 10,
                                  child: const HeroIcon(
                                    HeroIcons.clipboardDocumentList,
                                    size: 30,
                                  ))))
                      : null),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
