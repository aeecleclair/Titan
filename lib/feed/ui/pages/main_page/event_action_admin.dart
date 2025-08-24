import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/admin_news_list_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class EventActionAdmin extends ConsumerWidget {
  final News item;
  const EventActionAdmin({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizeWithContext = AppLocalizations.of(context)!;
    final newsAdminNotifier = ref.watch(adminNewsListProvider.notifier);
    return Align(
      alignment: Alignment.centerRight,
      child: WaitingButton(
        onTap: () async => await newsAdminNotifier.rejectNews(item),
        builder: (child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          width: 100,
          decoration: BoxDecoration(
            color: ColorConstants.main,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorConstants.onMain, width: 2),
          ),
          child: child,
        ),
        waitingColor: ColorConstants.background,
        child: Center(
          child: Text(
            localizeWithContext.eventDelete,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorConstants.background,
            ),
          ),
        ),
      ),
    );
  }
}
