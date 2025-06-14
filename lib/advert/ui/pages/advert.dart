import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/advert/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class AdvertTemplate extends HookConsumerWidget {
  final Widget child;
  const AdvertTemplate({super.key, required this.child});

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
                title: AdvertTextConstants.advert,
                root: AdvertRouter.root,
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
