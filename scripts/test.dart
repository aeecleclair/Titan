import 'dart:io';

void main() {
  final directoryPath = ".";
  final searchStart = "VoteTextConstants.";
  final replaceStart = "AppLocalizations.of(context)!.vote";
  final importStatement = "import 'package:titan/l10n/app_localizations.dart';";

  final directory = Directory(directoryPath);

  if (!directory.existsSync()) {
    print('Le dossier $directoryPath n\'existe pas.');
    exit(1);
  }

  final files = directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();

  print('Fichiers à traiter : ${files.length}');
  for (var i = 'a'.codeUnitAt(0); i <= 'z'.codeUnitAt(0); i++) {
    var letter = String.fromCharCode(i);
    final search = '$searchStart$letter';
    final replace = '$replaceStart${letter.toUpperCase()}';
    for (final file in files) {
      final content = file.readAsStringSync();

      if (content.contains(search)) {
        // Remplacer la chaîne
        var newContent = content.replaceAll(search, replace);

        // Ajouter l'import si absent
        if (!newContent.contains(importStatement)) {
          // Trouver la fin des imports existants
          final lines = newContent.split('\n');
          int insertIndex = 0;

          for (var j = 0; j < lines.length; j++) {
            final line = lines[j].trim();
            // On suppose que les imports commencent par 'import' ou 'part'
            if (line.startsWith('import ') || line.startsWith('part ')) {
              insertIndex = j + 1;
            } else if (line.isEmpty) {
              // Ignorer les lignes vides, continuer la recherche
              continue;
            } else {
              // On a atteint une ligne qui n'est ni import ni part ni vide -> stop
              break;
            }
          }

          lines.insert(insertIndex, importStatement);
          newContent = lines.join('\n');
        }

        file.writeAsStringSync(newContent);
        print('Modifié : ${file.path}');
      }
    }
  }

  print('Remplacement terminé.');
}
