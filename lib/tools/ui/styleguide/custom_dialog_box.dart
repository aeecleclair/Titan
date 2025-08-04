import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/providers/navbar_animation.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

const double padding = 20.0;

enum ModalType { main, danger }

class CustomDialogBox extends StatelessWidget {
  final String title, description;
  final String? yesText, noText;
  final ModalType type;
  final Function() onYes;
  final Function()? onNo;

  const CustomDialogBox({
    super.key,
    required this.title,
    required this.description,
    required this.onYes,
    this.type = ModalType.main,
    this.onNo,
    this.yesText,
    this.noText,
  });

  const CustomDialogBox.danger({
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        elevation: 0.0,
        insetPadding: const EdgeInsets.all(20.0),
        backgroundColor: type == ModalType.main
            ? ColorConstants.background
            : ColorConstants.main,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: type == ModalType.main
                      ? ColorConstants.tertiary
                      : ColorConstants.background,
                ),
              ),
              SizedBox(height: 20),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: type == ModalType.main
                      ? ColorConstants.tertiary
                      : ColorConstants.background,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 270,
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future showCustomDialog({
  required BuildContext context,
  required Widget dialog,
  required WidgetRef ref,
  Function? onCloseCallback,
}) async {
  final navbarAnimationNotifier = ref.watch(navbarAnimationProvider.notifier);
  navbarAnimationNotifier.toggle();
  await showDialog(
    useRootNavigator: true,
    context: context,
    builder: (_) => dialog,
  ).then((value) {
    navbarAnimationNotifier.toggle();
    onCloseCallback?.call();
  });
}
