import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/vote/class/members.dart';

class MemberCard extends ConsumerWidget {
  final Member member;
  final Function() onEdit, onDelete;
  final bool isAdmin;
  const MemberCard({
    super.key,
    required this.member,
    required this.onEdit,
    required this.onDelete,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListItem(
      title: member.getName(),
      subtitle: member.role,
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
                  title: member.getName(),
                  description: member.role,
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
