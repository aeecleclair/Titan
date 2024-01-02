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

  Future<bool> deleteLogs() async {
    return await delete((id) async => true, (listT, t) {
      logger.clearLogs();
      return [];
    }, "", Log.empty());
  }
}

final logsProvider =
    StateNotifierProvider<LogsProvider, AsyncValue<List<Log>>>((ref) {
  final logger = ref.watch(loggerProvider);
  LogsProvider notifier = LogsProvider(logger: logger);
  notifier.getLogs();
  return notifier;
});
