import 'package:titan/tools/logs/log.dart';

abstract class LoggerOutput {
  /// Initialize the logger output
  Future<void> init();

  /// Write a log to the output
  void writeLog(Log log);

  /// Get the logs from the output
  List<Log> getLogs();

  // Get the notification logs from the output
  List<Log> getNotificationLogs();

  /// Clear the logs from the output
  void clearLogs();

  /// Clear the notification logs from the output
  void clearNotificationLogs();
}
