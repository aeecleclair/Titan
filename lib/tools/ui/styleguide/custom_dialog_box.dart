import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

const double padding = 20.0;

enum ModalType { main, danger }

class ConfirmModal extends StatelessWidget {
  final String title, description;
  final String? yesText, noText;
  final ModalType type;
  final Function() onYes;
  final Function()? onNo;

  const ConfirmModal({
    super.key,
    required this.title,
    required this.description,
    required this.onYes,
    this.type = ModalType.main,
    this.onNo,
    this.yesText,
    this.noText,
  });

  const ConfirmModal.danger({
    super.key,
    required this.title,
    required this.description,
    required this.onYes,
    this.onNo,
    this.yesText,
    this.noText,
  }) : type = ModalType.danger;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;
    return BottomModalTemplate.danger(
      title: title,
      description: description,
      actions: [
        Row(
          children: [
            Expanded(
              child: Button(
                text: noText ?? localizeWithContext.globalCancel,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNo != null) {
                    onNo!();
                  }
                },
                type: ButtonType.secondary,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Button(
                text: yesText ?? localizeWithContext.globalConfirm,
                onPressed: () {
                  Navigator.of(context).pop();
                  onYes();
                },
                type: type == ModalType.main
                    ? ButtonType.main
                    : ButtonType.onDanger,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
      child: SizedBox.shrink(),
    );
  }
}
