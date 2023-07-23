import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/vote/providers/contender_logo_provider.dart';
import 'package:myecl/vote/providers/contender_logos_provider.dart';
import 'package:myecl/vote/providers/contender_provider.dart';
import 'package:myecl/vote/ui/components/member_card.dart';
import 'package:myecl/vote/ui/pages/admin_page/contender_card.dart';
import 'package:myecl/vote/ui/vote.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contenderLogos = ref.watch(contenderLogosProvider);
    final contender = ref.watch(contenderProvider);
    final contenderLogosNotifier = ref.watch(contenderLogosProvider.notifier);
    final logoNotifier = ref.watch(contenderLogoProvider.notifier);
    return VoteTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              contenderLogos.when(
                                  data: (data) {
                                    if (data[contender] != null) {
                                      return data[contender]!.when(
                                          data: (data) {
                                            if (data.isNotEmpty) {
                                              return Container(
                                                height: 140,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey.shade50,
                                                  image: DecorationImage(
                                                    image: data.first.image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      blurRadius: 10,
                                                      spreadRadius: 5,
                                                      offset:
                                                          const Offset(0, 5),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              logoNotifier
                                                  .getLogo(contender.id)
                                                  .then((value) {
                                                contenderLogosNotifier.setTData(
                                                    contender,
                                                    AsyncData([value]));
                                              });
                                              return const HeroIcon(
                                                HeroIcons.userCircle,
                                                size: 40,
                                              );
                                            }
                                          },
                                          loading: () => const SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Loader()),
                                          error: (error, stack) =>
                                              const SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Center(
                                                    child: HeroIcon(HeroIcons
                                                        .exclamationCircle),
                                                  )));
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                  loading: () => const Loader(),
                                  error: (error, stack) =>
                                      Text('Error $error')),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                contender.section.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  contender.description,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        contender.members.isNotEmpty
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Wrap(
                                  children: contender.members
                                      .map(
                                        (e) => MemberCard(
                                          member: e,
                                          isAdmin: false,
                                          onDelete: () {},
                                          onEdit: () {},
                                        ),
                                      )
                                      .toList(),
                                ))
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            contender.program,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (contender.program.trim().isNotEmpty)
                          const SizedBox(
                            height: 20,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ContenderCard(
                  contender: contender,
                  onEdit: () {},
                  isAdmin: false,
                  onDelete: () async {},
                  isDetail: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
