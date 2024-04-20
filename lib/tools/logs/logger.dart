import 'package:flutter/foundation.dart';
import 'package:myecl/tools/logs/file_logger_output.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:myecl/tools/logs/logger_output.dart';
import 'package:myecl/tools/logs/print_logger_output.dart';

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

  void clearLogs() {
    loggerOutput?.clearLogs();
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
}
