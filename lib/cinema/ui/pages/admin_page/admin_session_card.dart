import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/session_poster_map_provider.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AdminSessionCard extends HookConsumerWidget {
  final Session session;
  final VoidCallback onTap, onEdit;
  final Future Function() onDelete;
  const AdminSessionCard(
      {super.key,
      required this.session,
      required this.onTap,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionPosterMap = ref.watch(sessionPosterMapProvider);
    final sessionPosterMapNotifier =
        ref.watch(sessionPosterMapProvider.notifier);
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              sessionPosterMap.when(
                  data: (data) {
                    if (data[session] != null) {
                      return data[session]!.when(data: (data) {
                        if (data.isNotEmpty) {
                          return               Image(
                image: data.first.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              );
                        } else {
                          sessionPosterNotifier
                              .getLogo(session.id)
                              .then((value) {
                            sessionPosterMapNotifier.setTData(
                                session, AsyncData([value]));
                          });
                          return Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(0, 5),
                              ),
                            ]),
                          );
                        }
                      }, loading: () {
                        return const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }, error: (error, stack) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: HeroIcon(HeroIcons.exclamationCircle),
                          ),
                        );
                      });
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error $error')),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: MediaQuery.of(context).size.width - 260,
                child: Column(
                  children: [
                    AutoSizeText(
                      session.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
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
                            child: const HeroIcon(HeroIcons.pencil,
                                color: Colors.black),
                          ),
                        ),
                        ShrinkButton(
                          onTap: onDelete,
                          waitChild: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
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
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          ),
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
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
                            child: const HeroIcon(HeroIcons.trash,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
