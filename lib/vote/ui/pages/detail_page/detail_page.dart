import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/vote/providers/list_provider.dart';
import 'package:myecl/vote/ui/components/member_card.dart';
import 'package:myecl/vote/ui/pages/admin_page/list_card.dart';
import 'package:myecl/vote/ui/vote.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final listLogos = ref.watch(listLogosProvider);
    final list = ref.watch(listProvider);
    // final listLogosNotifier = ref.watch(listLogosProvider.notifier);
    // final logoNotifier = ref.watch(listLogoProvider.notifier);
    return VoteTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),
                              // if (listLogos[list.id] == null)
                              //   const SizedBox.shrink()
                              // else
                              //   SizedBox(
                              //     height: 140,
                              //     width: 140,
                              //     child: AsyncChild(
                              //       value: listLogos[list.id]!,
                              //       builder: (context, data) {
                              //         if (data.isEmpty) {
                              //           logoNotifier
                              //               .getLogo(list.id)
                              //               .then((value) {
                              //             listLogosNotifier.setTData(
                              //               list.id,
                              //               AsyncData([value]),
                              //             );
                              //           });
                              //           return const HeroIcon(
                              //             HeroIcons.userCircle,
                              //             size: 40,
                              //           );
                              //         }
                              //         return Container(
                              //           decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.grey.shade50,
                              //             image: DecorationImage(
                              //               image: data.first.image,
                              //               fit: BoxFit.cover,
                              //             ),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.grey
                              //                     .withValues(alpha: 0.2),
                              //                 blurRadius: 10,
                              //                 spreadRadius: 5,
                              //                 offset: const Offset(0, 5),
                              //               ),
                              //             ],
                              //           ),
                              //         );
                              //       },
                              //       errorBuilder: (error, stack) =>
                              //           const Center(
                              //         child: HeroIcon(
                              //           HeroIcons.exclamationCircle,
                              //           size: 40,
                              //         ),
                              //       ),
                              //     ),
                                // ),
                              const SizedBox(height: 20),
                              Text(
                                list.section.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AlignLeftText(
                                list.description,
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 20),
                              ),
                            ],
                          ),
                        ),
                        list.members.isNotEmpty
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Wrap(
                                  children: list.members
                                      .map((e) => MemberCard(member: e))
                                      .toList(),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            list.program ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if ((list.program ?? "").trim().isNotEmpty)
                          const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ListCard(list: list),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
