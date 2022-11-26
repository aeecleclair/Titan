import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/section_logo_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/logo_provider.dart';

class AssoUi extends HookConsumerWidget {
  final SimpleGroup group;
  final void Function() onTap, onEdit, onDelete;
  final bool isLoaner;
  const AssoUi(
      {super.key,
      required this.group,
      required this.onTap,
      required this.onEdit,
      required this.onDelete,
      required this.isLoaner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupLogos = ref.watch(allgroupLogosProvider);
    final groupLogosNotifier = ref.watch(allgroupLogosProvider.notifier);
    final logoNotifier = ref.watch(logoProvider.notifier);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: groupLogos.when(
                    data: (data) {
                      if (data[group] != null) {
                        return data[group]!.when(data: (data) {
                          if (data.isNotEmpty) {
                            return Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade300.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image:
                                      DecorationImage(image: data.first.image),
                                ));
                          } else {
                            logoNotifier.getLogo(group.id).then((value) {
                              groupLogosNotifier.setTData(
                                  group, AsyncData([value]));
                            });
                            return const HeroIcon(
                              HeroIcons.userCircle,
                              size: 120,
                            );
                          }
                        }, loading: () {
                          return const SizedBox(
                            height: 60,
                            width: 60,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }, error: (error, stack) {
                          return const SizedBox(
                            height: 60,
                            width: 60,
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
              ),
              if (isLoaner)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey.shade50,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: const HeroIcon(
                      HeroIcons.buildingLibrary,
                      color: Colors.black,
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade800,
                          Colors.grey.shade900,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: const HeroIcon(
                      HeroIcons.pencil,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          ColorConstants.gradient1,
                          ColorConstants.gradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.gradient2.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: const HeroIcon(
                      HeroIcons.xMark,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Column(
              //   children: [
              //     SizedBox(
              //       height: 110,
              //     ),
              //     Align(
              //       alignment: Alignment.center,
              //       child: Text(
              //         capitalize(group.name),
              //         style: const TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.w700,
              //             color: Colors.black),
              //       ),
              //     ),
              //   ],
              // )
            ]),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  capitalize(group.name),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return GestureDetector(
    //     behavior: HitTestBehavior.opaque,
    //     onTap: onTap,
    //     child: Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(right: 50),
    //               child: Text(
    //                 capitalize(group),
    //                 style: const TextStyle(
    //                     fontSize: 20, fontWeight: FontWeight.w500),
    //               ),
    //             ),
    //             Container(
    //               padding: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                   color: Colors.grey[200],
    //                   borderRadius: BorderRadius.circular(10)),
    //               child: const HeroIcon(
    //                 HeroIcons.chevronRight,
    //                 size: 25,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ],
    //         )));
  }
}
