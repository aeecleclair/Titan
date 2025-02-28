import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:myecl/tools/logs/logger.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LogsProvider extends ListNotifier<Log> {
  final Logger logger;
  LogsProvider({required this.logger}) : super(const AsyncValue.loading());

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

final logsProvider =
    StateNotifierProvider<LogsProvider, AsyncValue<List<Log>>>((ref) {
  final logger = ref.watch(loggerProvider);
  LogsProvider notifier = LogsProvider(logger: logger);
  notifier.getLogs();
  return notifier;
});

class NotificationLogsProvider extends ListNotifier<Log> {
  final Logger logger;
  NotificationLogsProvider({required this.logger})
      : super(const AsyncValue.loading());

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
    StateNotifierProvider<NotificationLogsProvider, AsyncValue<List<Log>>>(
        (ref) {
  final logger = ref.watch(loggerProvider);
  NotificationLogsProvider notifier = NotificationLogsProvider(logger: logger);
  notifier.getLogs();
  return notifier;
});
