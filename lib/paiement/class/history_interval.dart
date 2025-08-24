class HistoryInterval {
  final DateTime start;
  final DateTime end;

  HistoryInterval(this.start, this.end);

  @override
  String toString() {
    return 'HistoryInterval(start: $start, end: $end)';
  }

  bool contains(DateTime date) {
    return !date.isBefore(start) && !date.isAfter(end);
  }

  HistoryInterval.currentMonth()
    : start = DateTime(
        DateTime.now().year,
        DateTime.now().month - 1,
        DateTime.now().day,
      ),
      end = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
        59,
      );
}
