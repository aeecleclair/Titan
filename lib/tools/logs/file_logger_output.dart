import 'dart:io';

import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/logs/logger_output.dart';
import 'package:path_provider/path_provider.dart';

/// A logger output that writes logs to a file
class FileLoggerOutput implements LoggerOutput {
  static const String logFileName = 'myecl.log';
  late File logFile;

  // The maximum size of the log file, in bytes
  static const int maxFileSize = 1 * 1024 * 1024; // 1MB

  /// Get the log file
  /// If the file does not exist, create it
  Future<File> _getLogFile() async {
    Directory root = await getApplicationDocumentsDirectory();
    final path = '${root.path}/$logFileName';
    if (!(await File(path).exists())) {
      await File(path).create();
    }
    return File(path);
  }

  @override
  Future<void> init() async {
    logFile = await _getLogFile();

    // If the file is more than maxFileSize (in bytes), clear its content
    if (await logFile.length() > maxFileSize) {
      clearLogs();
    }
  }

  @override
  void writeLog(Log log) {
    try {
      logFile.writeAsStringSync(logToEscapedString(log), mode: FileMode.append);
    } catch (e) {
      print("Error writing log: $e"); // ignore: avoid_print
    }
  }

  /// Get the logs from the file
  /// The logs will be returned in reverse order, the most recent at the beginning
  @override
  List<Log> getLogs() {
    final String logsString = logFile.readAsStringSync();

    return logsFromEscapedString(
      logsString,
    ).where((element) => element.level != LogLevel.notification).toList();
  }

  /// Get the logs from the file
  /// The logs will be returned in reverse order, the most recent at the beginning
  @override
  List<Log> getNotificationLogs() {
    final String logsString = logFile.readAsStringSync();

    return logsFromEscapedString(
      logsString,
    ).where((element) => element.level == LogLevel.notification).toList();
  }

  /// Delete the non notification logs
  @override
  void clearLogs() {
    final String logsString = logFile.readAsStringSync();
    final notificationLogs = logsFromEscapedString(
      logsString,
    ).where((element) => element.level == LogLevel.notification).toList();
    logFile.writeAsStringSync("");
    for (Log log in notificationLogs) {
      writeLog(log);
    }
  }

  /// Delete the notification logs
  @override
  void clearNotificationLogs() {
    final String logsString = logFile.readAsStringSync();
    final logs = logsFromEscapedString(
      logsString,
    ).where((element) => element.level != LogLevel.notification).toList();
    logFile.writeAsStringSync("");
    for (Log log in logs) {
      writeLog(log);
    }
  }

  /// Escapes the message to be saved in a file.
  /// The string will be formatted as follows:
  /// [time] | [level] | [message];
  /// The message will have all "|" replaced with "-" and all ";" replaced with "".
  String logToEscapedString(Log log) {
    final escapedMessage = log.message.replaceAll("|", "-").replaceAll(";", "");
    return "${log.time.toIso8601String()} | ${log.level.name.toUpperCase()} | $escapedMessage;";
  }

  /// Return a Log object from a string that was previously escaped.
  /// The string should be formatted as follows:
  /// [time] | [level] | [message]
  /// NOTE: the last ";" should not be included.
  /// The message should have all "-" replaced with "|" and all ";" replaced with "".
  /// If the parsing fails, a Log object with an error message will be returned.
  static Log logFromEscapedString(String logString) {
    if (logString.isEmpty) {
      return Log.empty();
    }
    try {
      // We want to split on "|"
      final split = logString.split("|");
      return Log(
        time: DateTime.parse(split[0].trim()),
        level: LogLevel.values.firstWhere(
          (element) => element.name.toUpperCase() == split[1].trim(),
        ),
        message: split[2].trim(),
      );
    } catch (e) {
      return Log(
        level: LogLevel.error,
        message: "Parsing log $logString failed with error $e",
      );
    }
  }

  /// Return a list of Log object from a string that was previously escaped.
  /// The logs should be separated by ";"
  /// [time] | [level] | [message];
  /// The message should have all "-" replaced with "|" and all ";" replaced with "".
  /// If the parsing fails, a Log object with an error message will be returned.
  static List<Log> logsFromEscapedString(String logsString) {
    final logs = logsString.split(";");
    // The last element is always empty, because all logs end with ";"
    logs.removeLast();
    // We want to reverse the logs because the most recent is at the end
    return logs.reversed.map((log) => logFromEscapedString(log)).toList();
  }
}
