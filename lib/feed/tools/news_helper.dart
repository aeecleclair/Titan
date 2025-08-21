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

String formatUserFriendlyDate(
  DateTime date, {
  String locale = 'fr',
  required BuildContext context,
}) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dateDay = DateTime(date.year, date.month, date.day);

  final timeFormat = DateFormat('HH:mm');
  final time = timeFormat.format(date);

  final connector = AppLocalizations.of(context)?.dateAt ?? 'à';

  final difference = dateDay.difference(today).inDays;

  if (difference == 0) {
    return "${_capitalize(AppLocalizations.of(context)?.dateToday ?? 'Aujourd\'hui')} $connector $time";
  } else if (difference == -1) {
    return "${_capitalize(AppLocalizations.of(context)?.dateYesterday ?? 'Hier')} $connector $time";
  } else if (difference == 1) {
    return "${_capitalize(AppLocalizations.of(context)?.dateTomorrow ?? 'Demain')} $connector $time";
  } else if (difference > 1 && difference < 7) {
    final dayName = _capitalize(DateFormat('EEEE', locale).format(date));
    return "$dayName $connector $time";
  } else if (difference < 0 && difference > -7) {
    final dayName = _capitalize(DateFormat('EEEE', locale).format(date));
    final prefix = AppLocalizations.of(context)?.dateLast ?? '';

    final prefixWithSpace = prefix.isEmpty ? '' : _capitalize('$prefix ');
    return "$prefixWithSpace$dayName $connector $time";
  } else {
    if (date.year == now.year) {
      final monthDay = _capitalize(DateFormat('d MMM', locale).format(date));
      return "$monthDay $connector $time";
    } else {
      final dateFormat = locale == 'fr' ? 'd MMM yyyy' : 'MMM d, yyyy';
      final monthDayYear = _capitalize(
        DateFormat(dateFormat, locale).format(date),
      );
      return "$monthDayYear $connector $time";
    }
  }
}

String getNewsSubtitle(
  News news, {
  String locale = 'fr',
  required BuildContext context,
}) {
  String subtitle = '';

  final startDate = news.start.toLocal();

  if (isNewsOngoing(news) && news.end != null) {
    final untilText = _capitalize(
      AppLocalizations.of(context)?.dateUntil ??
          (locale == 'fr' ? "Jusqu'au" : "Until"),
    );
    subtitle =
        "$untilText ${formatUserFriendlyDate(news.end!.toLocal(), locale: locale, context: context)}";
  } else if (news.end == null) {
    subtitle = formatUserFriendlyDate(
      startDate,
      locale: locale,
      context: context,
    );
  } else {
    final endDate = news.end!.toLocal();
    bool sameDay =
        startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day;

    if (sameDay) {
      final connector = AppLocalizations.of(context)?.dateAt ?? 'à';

      String dateStr = formatUserFriendlyDate(
        startDate,
        locale: locale,
        context: context,
      ).split(' $connector ')[0];

      final startTime = DateFormat('HH:mm').format(startDate);
      final endTime = DateFormat('HH:mm').format(endDate);

      final fromWord = AppLocalizations.of(context)?.dateFrom ?? 'de';
      final toWord = AppLocalizations.of(context)?.dateTo ?? 'à';

      subtitle = '$dateStr $fromWord $startTime $toWord $endTime';
    } else {
      final fromWord = _capitalize(
        AppLocalizations.of(context)?.dateFrom ?? 'de',
      );

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final endDateTime = DateTime(endDate.year, endDate.month, endDate.day);
      final difference = endDateTime.difference(today).inDays;

      final toWord = (difference >= -1 && difference <= 1)
          ? (AppLocalizations.of(context)?.dateTo ?? 'à')
          : (AppLocalizations.of(context)?.dateBetweenDays ?? 'au');

      subtitle =
          '$fromWord ${formatUserFriendlyDate(startDate, locale: locale, context: context)} $toWord ${formatUserFriendlyDate(endDate, locale: locale, context: context)}';
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
    return AppLocalizations.of(context)?.eventActionCampaign ?? 'Tu peux voter';
  } else if (module == "event") {
    return AppLocalizations.of(context)?.eventActionEvent ?? 'Tu est invité';
  }
  return '';
}

String getActionSubtitle(News news, BuildContext context) {
  final module = news.module;

  if (module == "campagne") {
    return AppLocalizations.of(context)?.eventActionCampaignSubtitle ??
        'Votes maintenant';
  } else if (module == "event") {
    return AppLocalizations.of(context)?.eventActionEventSubtitle ??
        'Réponds à l\'invitation';
  }
  return '';
}

String getActionEnableButtonText(News news, BuildContext context) {
  final module = news.module;

  if (module == "campagne") {
    return AppLocalizations.of(context)?.eventActionCampaignButton ?? 'Voter';
  } else if (module == "event") {
    return AppLocalizations.of(context)?.eventActionEventButton ?? 'Participer';
  }
  return '';
}

String getActionValidatedButtonText(News news, BuildContext context) {
  final module = news.module;

  if (module == "campagne") {
    return AppLocalizations.of(context)?.eventActionCampaignValidated ??
        'J\'ai voté !';
  } else if (module == "event") {
    return AppLocalizations.of(context)?.eventActionEventValidated ??
        'Je viens !';
  }
  return '';
}

void getActionButtonAction(
  News news,
  BuildContext context,
  WidgetRef ref,
) async {
  final module = news.module;

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
          displayToast(context, TypeMsg.error, 'Impossible d\'ouvrir le lien');
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
