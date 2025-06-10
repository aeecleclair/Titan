import 'package:flutter/foundation.dart';
import 'package:titan/service/class/message.dart';
import 'package:titan/tools/logs/file_logger_output.dart';
import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/logs/logger_output.dart';
import 'package:titan/tools/logs/print_logger_output.dart';

class Logger {
  LoggerOutput? loggerOutput;

  /// The log level of the logger
  /// Only logs with a level equal to or higher than this level will be written
  LogLevel minimalLogLevel = LogLevel.warning;

  Logger() {
    init();
  }

  void init() async {
    if (kIsWeb) {
      loggerOutput = PrintLoggerOutput();
      await loggerOutput!.init();
    } else {
      loggerOutput = FileLoggerOutput();
      await loggerOutput!.init();
    }
  }

  void writeLog(Log log) {
    if (log.level.index >= minimalLogLevel.index) {
      loggerOutput?.writeLog(log);
    }
  }

  List<Log> getLogs() {
    return loggerOutput?.getLogs() ?? [];
  }

  List<Log> getNotificationLogs() {
    return loggerOutput?.getNotificationLogs() ?? [];
  }

  void clearLogs() {
    loggerOutput?.clearLogs();
  }

  void clearNotificationLogs() {
    loggerOutput?.clearNotificationLogs();
  }

  void debug(String message) {
    writeLog(Log(message: message, level: LogLevel.debug));
  }

  void info(String message) {
    writeLog(Log(message: message, level: LogLevel.info));
  }

  void warning(String message) {
    writeLog(Log(message: message, level: LogLevel.warning));
  }

  void error(String message) {
    writeLog(Log(message: message, level: LogLevel.error));
  }

  void logException(Exception e) {
    error(e.toString());
  }

  void logNotification(Message message) {
    final messageString = message.toJson().toString();
    writeLog(Log(message: messageString, level: LogLevel.notification));
  }
}
