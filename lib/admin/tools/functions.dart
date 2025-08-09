List<String> getMailListFromCSV(String fileContent) {
  final lines = fileContent.split('\n');
  final List<String> emails = [];

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    if (line.isEmpty) continue;

    final columns = line.split(',');

    final email = columns[0].trim();
    emails.add(email);
  }
  return emails;
}
