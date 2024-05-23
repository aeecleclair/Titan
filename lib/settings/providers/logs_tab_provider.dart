import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LogTabs { log, notification }

class LogTabsNotifier extends StateNotifier<LogTabs> {
  LogTabsNotifier() : super(LogTabs.log);

  void setLogTabs(LogTabs i) {
    state = i;
  }
}

final logTabProvider = StateNotifierProvider<LogTabsNotifier, LogTabs>((ref) {
  return LogTabsNotifier();
});
