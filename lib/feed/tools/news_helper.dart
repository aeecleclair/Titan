import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/feed/class/news.dart';
import 'package:intl/intl.dart';
import 'package:titan/feed/providers/event_ticket_url_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/vote/router.dart';
import 'package:url_launcher/url_launcher.dart';

String _capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

bool isNewsTerminated(News news) {
  final now = DateTime.now();
  if (news.end != null && news.end!.isBefore(now)) {
    return true;
  }
  return false;
}

bool isNewsOngoing(News news) {
  final now = DateTime.now();
  if (news.start.isBefore(now) &&
      (news.end == null || news.end!.isAfter(now))) {
    return true;
  }
  return false;
}

String formatUserFriendlyDate(DateTime date, {required BuildContext context}) {
  final locale = Localizations.localeOf(context).toString();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dateDay = DateTime(date.year, date.month, date.day);

  final timeFormat = DateFormat.Hm(locale);
  final time = timeFormat.format(date);

  final connector = AppLocalizations.of(context)!.dateAt;

  final difference = dateDay.difference(today).inDays;

  if (difference == 0) {
    return "${_capitalize(AppLocalizations.of(context)!.dateToday)} $connector $time";
  } else if (difference == -1) {
    return "${_capitalize(AppLocalizations.of(context)!.dateYesterday)} $connector $time";
  } else if (difference == 1) {
    return "${_capitalize(AppLocalizations.of(context)!.dateTomorrow)} $connector $time";
  } else if (difference > 1 && difference < 7) {
    final dayName = _capitalize(DateFormat.EEEE(locale).format(date));
    return "$dayName $connector $time";
  } else if (difference < 0 && difference > -7) {
    final dayName = _capitalize(DateFormat.EEEE(locale).format(date));
    final prefix = AppLocalizations.of(context)!.dateLast;

    final prefixWithSpace = prefix.isEmpty ? '' : _capitalize('$prefix ');
    return "$prefixWithSpace$dayName $connector $time";
  } else {
    if (date.year == now.year) {
      final monthDay = _capitalize(DateFormat.MMMd(locale).format(date));
      return "$monthDay $connector $time";
    } else {
      final monthDayYear = _capitalize(DateFormat.yMMMMd(locale).format(date));
      return "$monthDayYear $connector $time";
    }
  }
}

String getNewsSubtitle(News news, {required BuildContext context}) {
  final locale = Localizations.localeOf(context).toString();
  String subtitle = '';

  final startDate = news.start.toLocal();

  if (isNewsOngoing(news) && news.end != null) {
    final untilText = _capitalize(AppLocalizations.of(context)!.dateUntil);
    subtitle =
        "$untilText ${formatUserFriendlyDate(news.end!.toLocal(), context: context)}";
  } else if (news.end == null) {
    subtitle = formatUserFriendlyDate(startDate, context: context);
  } else {
    final endDate = news.end!.toLocal();
    bool sameDay =
        startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day;

    if (sameDay) {
      final connector = AppLocalizations.of(context)!.dateAt;

      String dateStr = formatUserFriendlyDate(
        startDate,
        context: context,
      ).split(' $connector ')[0];

      final startTime = DateFormat.Hm(locale).format(startDate);
      final endTime = DateFormat.Hm(locale).format(endDate);

      final fromWord = AppLocalizations.of(context)!.dateFrom;
      final toWord = AppLocalizations.of(context)!.dateTo;

      subtitle = '$dateStr $fromWord $startTime $toWord $endTime';
    } else {
      final fromWord = _capitalize(AppLocalizations.of(context)!.dateFrom);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final endDateTime = DateTime(endDate.year, endDate.month, endDate.day);
      final difference = endDateTime.difference(today).inDays;

      final toWord = (difference >= -1 && difference <= 1)
          ? (AppLocalizations.of(context)!.dateTo)
          : (AppLocalizations.of(context)!.dateBetweenDays);

      subtitle =
          '$fromWord ${formatUserFriendlyDate(startDate, context: context)} $toWord ${formatUserFriendlyDate(endDate, context: context)}';
    }
  }

  if (subtitle.isEmpty) {
    subtitle = news.entity;
  }

  return subtitle;
}

String getActionTitle(News news, BuildContext context) {
  final module = news.module;

  if (module == "campagne") {
    return AppLocalizations.of(context)!.eventActionCampaign;
  } else if (module == "event") {
    return AppLocalizations.of(context)!.eventActionEvent;
  }
  return '';
}

String getWaitingTitle(
  News news,
  BuildContext context, {
  required String timeToGo,
}) {
  final module = news.module;
  final localizeWithContext = AppLocalizations.of(context)!;

  if (module == "campagne") {
    return localizeWithContext.feedVoteIn(timeToGo);
  } else if (module == "event") {
    return localizeWithContext.feedShotgunIn(timeToGo);
  }
  return '';
}

String getActionSubtitle(News news, BuildContext context) {
  final module = news.module;

  if (module == "campagne") {
    return AppLocalizations.of(context)!.eventActionCampaignSubtitle;
  } else if (module == "event") {
    return AppLocalizations.of(context)!.eventActionEventSubtitle;
  }
  return '';
}

String getActionEnableButtonText(News news, BuildContext context) {
  final module = news.module;

  if (module == "campagne") {
    return AppLocalizations.of(context)!.eventActionCampaignButton;
  } else if (module == "event") {
    return AppLocalizations.of(context)!.eventActionEventButton;
  }
  return '';
}

String getActionValidatedButtonText(News news, BuildContext context) {
  final module = news.module;
  final localizeWithContext = AppLocalizations.of(context)!;

  if (module == "campagne") {
    return localizeWithContext.eventActionCampaignValidated;
  } else if (module == "event") {
    return localizeWithContext.eventActionEventValidated;
  }
  return '';
}

void getActionButtonAction(
  News news,
  BuildContext context,
  WidgetRef ref,
) async {
  final module = news.module;
  final localizeWithContext = AppLocalizations.of(context)!;

  if (module == "campagne") {
    QR.to(VoteRouter.root);
  } else if (module == "event") {
    final ticketUrlNotifier = ref.watch(ticketUrlProvider.notifier);
    final ticketUrl = await ticketUrlNotifier.getTicketUrl(news.moduleObjectId);
    ticketUrl.when(
      data: (ticketUrl) async {
        if (await canLaunchUrl(Uri.parse(ticketUrl.ticketUrl))) {
          await launchUrl(
            Uri.parse(ticketUrl.ticketUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          if (!context.mounted) return;
          displayToast(
            context,
            TypeMsg.error,
            localizeWithContext.feedCantOpenLink,
          );
        }
      },
      error: (e, stackTrace) {
        displayToast(context, TypeMsg.error, e.toString());
      },
      loading: () {},
    );
  } else if (module == "advert") {
    // TODO : set id
    QR.to(AdvertRouter.root);
  }
  return;
}
