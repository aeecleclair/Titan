import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarDialogButton extends StatelessWidget {
  final String? uri;
  final HeroIcons icon;
  const CalendarDialogButton({
    super.key,
    required this.uri,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    void displayToastWithoutContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return GestureDetector(
      onTap: uri != null
          ? () async {
              try {
                await launchUrl(
                  Uri.parse(uri!),
                );
              } catch (e) {
                displayToastWithoutContext(TypeMsg.error, e.toString());
              }
            }
          : null,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: HeroIcon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
