import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/async_child.dart';
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
    return AsyncChild(
        value: contenderLogos,
        builder: (context, data) {
          if (data[contender] == null) {
            return const SizedBox.shrink();
          }
          return SizedBox(
              height: 40,
              width: 40,
              child: AsyncChild(
                  value: data[contender]!,
                  builder: (context, data) {
                    if (data.isEmpty) {
                      Future.delayed(const Duration(milliseconds: 1), () {
                        contenderLogosNotifier.setTData(
                            contender, const AsyncLoading());
                      });
                      tokenExpireWrapper(ref, () async {
                        logoNotifier.getLogo(contender.id).then((value) {
                          contenderLogosNotifier.setTData(
                              contender, AsyncData([value]));
                        });
                      });
                      return const HeroIcon(
                        HeroIcons.userCircle,
                        size: 40,
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: data.first.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (error, stack) => const Center(
                      child: HeroIcon(HeroIcons.exclamationCircle))));
        });
  }
}
