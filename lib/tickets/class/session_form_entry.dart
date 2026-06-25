class SessionFormEntry {
  final String label;
  final DateTime? startDatetime;
  final String quota;

  const SessionFormEntry({
    this.label = '',
    this.startDatetime,
    this.quota = '',
  });

  SessionFormEntry copyWith({
    String? label,
    DateTime? startDatetime,
    String? quota,
  }) {
    return SessionFormEntry(
      label: label ?? this.label,
      startDatetime: startDatetime ?? this.startDatetime,
      quota: quota ?? this.quota,
    );
  }
}

class SessionsFormState {
  final List<SessionFormEntry> entries;

  SessionsFormState({List<SessionFormEntry>? entries})
    : entries = entries ?? [const SessionFormEntry()];
}
