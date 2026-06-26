List<String> parseCsvContent(String content) {
  if (content.isEmpty) return [];

  final separators = [',', ';', '\t', '|'];

  // Simple heuristic: count occurrences of each separator in the entire content
  String bestSeparator = ',';
  int maxOccurrences = 0;

  for (final separator in separators) {
    final occurrences = separator.allMatches(content).length;

    if (occurrences > maxOccurrences) {
      maxOccurrences = occurrences;
      bestSeparator = separator;
    }
  }

  final lines = content.split('\n').where((line) => line.trim().isNotEmpty);
  final result = <String>[];

  for (final line in lines) {
    final fields = line
        .split(bestSeparator)
        .map((field) => field.trim())
        .where((field) => field.isNotEmpty && _isValidEmail(field));
    result.addAll(fields);
  }

  return result.toSet().toList();
}

bool _isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email.trim());
}
