enum LogLevel { debug, info, warning, error, notification }

class Log {
  late final String message;
  late final LogLevel level;
  final DateTime time;

  Log({required this.message, required this.level, DateTime? time})
    : time = time ?? DateTime.now();

  Log.empty() : message = "", level = LogLevel.debug, time = DateTime.now();

  Log copyWith({String? message, LogLevel? level, DateTime? time}) {
    return Log(
      message: message ?? this.message,
      level: level ?? this.level,
      time: time ?? this.time,
    );
  }

  /// The string will be formatted as follows:
  /// [time] | [level] | [message]
  @override
  String toString() {
    return "${time.toIso8601String()} | ${level.name.toUpperCase()} | $message";
  }
}
