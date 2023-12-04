import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/vote/providers/contender_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/ui/components/contender_logo.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ContenderCard extends HookConsumerWidget {
  final ListReturn contender;
  final bool isAdmin, isDetail;
  final Function()? onEdit;
  final Future Function()? onDelete;
  const ContenderCard(
      {super.key,
      required this.contender,
      this.onEdit,
      this.onDelete,
      this.isAdmin = false,
      this.isDetail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contenderNotifier = ref.watch(contenderProvider.notifier);
    final status = ref
        .watch(statusProvider)
        .maybeWhen(data: (status) => status, orElse: () => StatusType.waiting);
    return CardLayout(
        id: contender.id,
        width: 250,
        height: (contender.type != ListType.blank &&
                status == StatusType.waiting &&
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
                ContenderLogo(contender),
                const SizedBox(width: 10),
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
                              contender.type.toString().split('.').last),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 3),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                isDetail || contender.type == ListType.blank
                    ? Container(width: 30)
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
            if (contender.type != ListType.blank &&
                status == StatusType.waiting &&
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
                  WaitingButton(
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
