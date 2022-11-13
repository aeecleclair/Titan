String formatSessionDateAndDuration(DateTime date, int duration) {
  return "Le ${formatDate(date)} - ${formatDuration(duration)}";
}

String formatDuration(int duration) {
  final hours = duration ~/ 60;
  final minutes = duration % 60;
  if (hours == 0) {
    return "${minutes}m";
  } else if (minutes == 0) {
    return "${hours}h";
  } else {
    return "${hours}h ${minutes}min";
  }
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

int parseDuration(String duration) {
  final parts = duration.split(":");
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);
  return hours * 60 + minutes;
}

String parseDurationBack(int duration) {
  final hours = duration ~/ 60;
  final minutes = duration % 60;
  return "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}";
}
