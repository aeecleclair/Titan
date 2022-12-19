import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/providers/pretendance_logo_provider.dart';
import 'package:myecl/vote/providers/pretendance_logos_provider.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/ui/member_card.dart';
import 'package:myecl/vote/ui/pages/admin_page/pretendance_card.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pretendanceLogos = ref.watch(pretendanceLogosProvider);
    final pretendance = ref.watch(pretendanceProvider);
    final pretendanceLogosNotifier =
        ref.watch(pretendanceLogosProvider.notifier);
    final logoNotifier = ref.watch(pretendenceLogoProvider.notifier);
    return SingleChildScrollView(
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
                            pretendanceLogos.when(
                                data: (data) {
                                  if (data[pretendance] != null) {
                                    return data[pretendance]!.when(
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
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        logoNotifier
                                            .getLogo(pretendance.id)
                                            .then((value) {
                                          pretendanceLogosNotifier.setTData(
                                              pretendance, AsyncData([value]));
                                        });
                                        return const HeroIcon(
                                          HeroIcons.userCircle,
                                          size: 40,
                                        );
                                      }
                                    }, loading: () {
                                      return const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }, error: (error, stack) {
                                      return const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Center(
                                          child: Icon(Icons.error),
                                        ),
                                      );
                                    });
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (error, stack) => Text('Error $error')),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              pretendance.section.name,
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
                                pretendance.description,
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
                      pretendance.members.isNotEmpty
                          ? GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pretendance.members.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 1),
                              itemBuilder: (context, index) {
                                return MemberCard(
                                    member: pretendance.members[index],
                                    isAdmin: false,
                                    onDelete: () {},
                                    onEdit: () {});
                              },
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          pretendance.program,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (pretendance.program.trim().isNotEmpty)
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
              child: PretendanceCard(
                pretendance: pretendance,
                onEdit: () {},
                isAdmin: false,
                onDelete: () {},
                isDetail: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
