import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_logo_provider.dart';
import 'package:titan/vote/providers/contender_logos_provider.dart';

class ContenderLogo extends HookConsumerWidget {
  final Contender contender;
  const ContenderLogo(this.contender, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contenderLogos = ref.watch(
      contenderLogosProvider.select((value) => value[contender.id]),
    );
    final contenderLogosNotifier = ref.read(contenderLogosProvider.notifier);
    final logoNotifier = ref.read(contenderLogoProvider.notifier);
    return AutoLoaderChild(
      group: contenderLogos,
      notifier: contenderLogosNotifier,
      mapKey: contender.id,
      loader: (contenderId) => logoNotifier.getLogo(contenderId),
      dataBuilder: (context, logo) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: logo.first.image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
