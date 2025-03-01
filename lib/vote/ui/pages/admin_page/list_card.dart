import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/vote/providers/list_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/ui/components/list_logo.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ListCard extends HookConsumerWidget {
  final ListReturn list;
  final bool isAdmin, isDetail;
  final Function()? onEdit;
  final Future Function()? onDelete;
  const ListCard({
    super.key,
    required this.list,
    this.onEdit,
    this.onDelete,
    this.isAdmin = false,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNotifier = ref.watch(listProvider.notifier);
    final status = ref
        .watch(statusProvider)
        .maybeWhen(data: (status) => status.status, orElse: () => StatusType.waiting);
    return CardLayout(
      id: list.id,
      width: 250,
      height: (list.type != ListType.blank &&
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
              ListLogo(list),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    AutoSizeText(
                      list.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      capitalize(
                        list.type.name,
                      ),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              isDetail || list.type == ListType.blank
                  ? Container(width: 30)
                  : GestureDetector(
                      onTap: () {
                        listNotifier.setId(list);
                        QR.to(VoteRouter.root + VoteRouter.detail);
                      },
                      child: const HeroIcon(
                        HeroIcons.informationCircle,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
            ],
          ),
          Center(
            child: Text(
              list.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          const Spacer(),
          if (list.type != ListType.blank &&
              status == StatusType.waiting &&
              isAdmin)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: CardButton(
                    color: Colors.grey.shade200,
                    shadowColor: Colors.grey.withValues(alpha: 0.2),
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
      ),
    );
  }
}
