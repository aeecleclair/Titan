import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/logs/logger_output.dart';

/// A logger output that writes logs to a file
class PrintLoggerOutput implements LoggerOutput {
  @override
  Future<void> init() async {}

  @override
  void writeLog(Log log) {
    print(log.toString()); // ignore: avoid_print
  }

  /// Get the logs from the file
  /// The logs will be returned in reverse order, the most recent at the beginning
  @override
  List<Log> getLogs() {
    return [];
  }

  /// Get the logs from the file
  /// The logs will be returned in reverse order, the most recent at the beginning
  @override
  List<Log> getNotificationLogs() {
    return [];
  }

  /// Delete the content of the log file
  @override
  void clearLogs() {}

  /// Delete the content of the log file
  @override
  void clearNotificationLogs() {}
}
