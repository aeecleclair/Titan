import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/meta/router.dart';
import 'package:myecl/meta/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class MetaTemplate extends HookConsumerWidget {
  final Widget child;
  const MetaTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAnnouncersNotifier = ref.read(announcerProvider.notifier);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              TopBar(
                title: MetaTextConstants.advert,
                root: MetaRouter.root,
                onBack: () {
                  selectedAnnouncersNotifier.clearAnnouncer();
                },
              ),
              const SizedBox(height: 30),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
