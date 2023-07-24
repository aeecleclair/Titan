import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/card_button.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/contender_logo_provider.dart';
import 'package:myecl/vote/providers/contender_logos_provider.dart';
import 'package:myecl/vote/providers/contender_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ContenderCard extends HookConsumerWidget {
  final Contender contender;
  final bool isAdmin, isDetail;
  final Function() onEdit;
  final Future Function() onDelete;
  static void noAction() {}
  static Future noAsyncAction() async {}
  const ContenderCard(
      {super.key,
      required this.contender,
      this.onEdit = noAction,
      this.onDelete = noAsyncAction,
      this.isAdmin = false,
      this.isDetail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contenderNotifier = ref.watch(contenderProvider.notifier);
    final status = ref.watch(statusProvider).when(
          data: (status) => status,
          loading: () => Status.waiting,
          error: (error, stackTrace) => Status.waiting,
        );
    final contenderLogos = ref.watch(contenderLogosProvider);
    final contenderLogosNotifier = ref.watch(contenderLogosProvider.notifier);
    final logoNotifier = ref.watch(contenderLogoProvider.notifier);
    return CardLayout(
        width: 250,
        height: (contender.listType != ListType.blank &&
                status == Status.waiting &&
                isAdmin)
            ? 180
            : 130,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                contenderLogos.when(
                    data: (data) {
                      if (data[contender] != null) {
                        return data[contender]!.when(data: (data) {
                          if (data.isNotEmpty) {
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: data.first.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            Future.delayed(
                                const Duration(milliseconds: 1),
                                () => contenderLogosNotifier.setTData(
                                    contender, const AsyncLoading()));
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
                        }, loading: () {
                          return const SizedBox(
                              height: 40, width: 40, child: Loader());
                        }, error: (error, stack) {
                          return const SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: HeroIcon(HeroIcons.exclamationCircle),
                            ),
                          );
                        });
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    loading: () => const Loader(),
                    error: (error, stack) => Text('Error $error')),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      AutoSizeText(contender.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                          capitalize(
                              contender.listType.toString().split('.').last),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                isDetail || contender.listType == ListType.blank
                    ? Container(
                        width: 30,
                      )
                    : GestureDetector(
                        onTap: () {
                          contenderNotifier.setId(contender);
                          QR.to(VoteRouter.root + VoteRouter.detail);
                        },
                        child: const HeroIcon(
                          HeroIcons.informationCircle,
                          color: Colors.black,
                          size: 25,
                        ),
                      )
              ],
            ),
            Center(
              child: Text(contender.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400)),
            ),
            const Spacer(),
            if (contender.listType != ListType.blank &&
                status == Status.waiting &&
                isAdmin)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: CardButton(
                      color: Colors.grey.shade200,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child:
                          const HeroIcon(HeroIcons.pencil, color: Colors.black),
                    ),
                  ),
                  ShrinkButton(
                    builder: (child) =>
                        CardButton(color: Colors.black, child: child),
                    onTap: onDelete,
                    child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                  ),
                ],
              ),
          ],
        ));
  }
}
