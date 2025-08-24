import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/ui/components/contender_logo.dart';

class ContenderCard extends HookConsumerWidget {
  final Contender contender;
  final bool isAdmin, isDetail;
  final Function() onEdit;
  final Future Function() onDelete;
  const ContenderCard({
    super.key,
    required this.contender,
    required this.onEdit,
    required this.onDelete,
    this.isAdmin = false,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListItem(
      title: contender.name,
      subtitle: contender.listType.name,
      icon: ContenderLogo(contender),
      onTap: isAdmin
          ? () async {
              FocusScope.of(context).unfocus();
              final ctx = context;
              await Future.delayed(Duration(milliseconds: 150));
              if (!ctx.mounted) return;

              await showCustomBottomModal(
                context: ctx,
                ref: ref,
                modal: BottomModalTemplate(
                  title: contender.name,
                  description: contender.program,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Button(
                        text: AppLocalizations.of(context)!.voteEdit,
                        onPressed: onEdit,
                      ),
                      const SizedBox(height: 20),
                      Button.danger(text: AppLocalizations.of(context)!.voteDelete, onPressed: onDelete),
                    ],
                  ),
                ),
              );
            }
          : null,
    );
  }
}
