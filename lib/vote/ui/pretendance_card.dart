import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/logo_provider.dart';
import 'package:myecl/vote/providers/pretendance_logo_provider.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';

class PretendanceCard extends HookConsumerWidget {
  final Pretendance pretendance;
  final bool isAdmin;
  final Function() onEdit, onDelete;
  const PretendanceCard(
      {super.key,
      required this.pretendance,
      required this.onEdit,
      required this.onDelete,
      required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);
    final status = ref.watch(statusProvider).when(
          data: (status) => status,
          loading: () => Status.waiting,
          error: (error, stackTrace) => Status.waiting,
        );
    final pretendanceLogos = ref.watch(pretendanceLogosProvider);
    final pretendanceLogosNotifier =
        ref.watch(pretendanceLogosProvider.notifier);
    final logoNotifier = ref.watch(logoProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: (pretendance.listType != ListType.blank &&
                  status == Status.waiting &&
                  isAdmin)
              ? 180
              : 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pretendanceLogos.when(
                        data: (data) {
                          if (data[pretendance] != null) {
                            return data[pretendance]!.when(data: (data) {
                              if (data.isNotEmpty) {
                                return CircleAvatar(
                                  radius: 20,
                                  backgroundImage: data.first.image,
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
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stack) => const Text('Error')),
                    Column(
                      children: [
                        Text(pretendance.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(
                            capitalize(pretendance.listType
                                .toString()
                                .split('.')
                                .last),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        pretendanceNotifier.setId(pretendance);
                        pageNotifier.setVotePage(VotePage.detailPageFromAdmin);
                      },
                      child: HeroIcon(
                        HeroIcons.informationCircle,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(pretendance.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400)),
                ),
                const Spacer(),
                if (pretendance.listType != ListType.blank &&
                    status == Status.waiting &&
                    isAdmin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const Icon(Icons.edit, color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )),
    );
  }
}
