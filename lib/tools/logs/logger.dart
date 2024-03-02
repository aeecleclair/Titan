import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:path_provider/path_provider.dart';

class Logger {
  final String logFileName = 'myecl.log';
  late File logFile;

  Logger() {
    init();
  }

  void init() async {
    if (!kIsWeb) {
      Directory root = await getApplicationDocumentsDirectory();
      final path = '${root.path}/$logFileName';
      if (!(await File(path).exists())) {
        await File(path).create();
        logFile = File(path);
      }
    }
  }

  bool writeLog(Log log) {
    if (kIsWeb) {
      return false;
    }
    try {
      logFile.writeAsStringSync(log.toString(), mode: FileMode.append);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Log> getLogs() {
    if (kIsWeb) {
      return [];
    }
    return logFile
        .readAsStringSync()
        .split(";")
        .reversed
        .toList()
        .sublist(1)
        .map((e) {
      final split = e.split(" - ");
      if (split.length < 2) {
        return Log.empty().copyWith(message: e);
      }
      String message = split[1].split(": ").last;
      String level = split[1].split(": ").first;
      return Log(
        message: message,
        level: LogLevel.values.firstWhere((element) =>
            element.toString().split(".").last.toUpperCase() == level),
        time: DateTime.parse(split[0]),
      );
    }).toList();
  }

  void clearLogs() {
    if (kIsWeb) {
      return;
    }
    logFile.writeAsStringSync("");
  }
}
