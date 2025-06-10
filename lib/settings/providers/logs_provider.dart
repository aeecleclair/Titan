import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/logs/logger.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class LogsProvider extends ListNotifier<Log> {
  Logger logger = Repository.logger;
  LogsProvider() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Log>>> getLogs() async {
    return await loadList(() async => logger.getLogs());
  }

  Future<List<Log>> getNotificationLogs() async {
    return logger.getNotificationLogs();
  }

  Future<bool> deleteLogs() async {
    return await delete(
      (id) async => true,
      (listT, t) {
        logger.clearLogs();
        return [];
      },
      "",
      Log.empty(),
    );
  }
}

final logsProvider = StateNotifierProvider<LogsProvider, AsyncValue<List<Log>>>(
  (ref) {
    LogsProvider notifier = LogsProvider();
    notifier.getLogs();
    return notifier;
  },
);

class NotificationLogsProvider extends ListNotifier<Log> {
  Logger logger = Repository.logger;
  NotificationLogsProvider() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Log>>> getLogs() async {
    return await loadList(() async => logger.getNotificationLogs());
  }

  Future<bool> deleteLogs() async {
    return await delete(
      (id) async => true,
      (listT, t) {
        logger.clearNotificationLogs();
        return [];
      },
      "",
      Log.empty(),
    );
  }
}

final notificationLogsProvider =
    StateNotifierProvider<NotificationLogsProvider, AsyncValue<List<Log>>>((
      ref,
    ) {
      NotificationLogsProvider notifier = NotificationLogsProvider();
      notifier.getLogs();
      return notifier;
    });
