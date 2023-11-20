import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/contender_logo_provider.dart';
import 'package:myecl/vote/providers/contender_logos_provider.dart';

class ContenderLogo extends HookConsumerWidget {
  final Contender contender;
  const ContenderLogo(this.contender, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contenderLogos = ref.watch(contenderLogosProvider);
    final contenderLogosNotifier = ref.read(contenderLogosProvider.notifier);
    final logoNotifier = ref.read(contenderLogoProvider.notifier);
    return AutoLoaderChild(
        value: contenderLogos,
        notifier: contenderLogosNotifier,
        mapKey: contender,
        loader: (contender) => logoNotifier.getLogo(contender.id),
        dataBuilder: (context, logo) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: logo.first.image,
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }
}
