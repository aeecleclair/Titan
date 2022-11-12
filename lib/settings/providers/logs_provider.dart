import 'package:f_logs/f_logs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LogsProvider extends ListNotifier<Log> {
  LogsProvider() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Log>>> getLogs() async {
    return await loadList(() async => FLog.getAllLogsByFilter(logLevels: [
          LogLevel.DEBUG.toString(),
          LogLevel.ERROR.toString(),
          LogLevel.FATAL.toString(),
          LogLevel.WARNING.toString(),
        ]).then((value) => value.reversed.toList()));
  }
}

final logsProvider =
    StateNotifierProvider<LogsProvider, AsyncValue<List<Log>>>((ref) {
  LogsProvider notifier = LogsProvider();
  notifier.getLogs();
  return notifier;
});
