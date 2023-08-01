import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

// enum CinemaTable {
//   session
// }

// CinemaTable getCinemaTable(String table) {
//   final enumsName = { for (var v in CinemaTable.values) v.toString() : v };
//   return enumsName[table] ?? CinemaTable.values.first;
// }

// Future<String> handleCinemaAction(WidgetRef ref, String table) async {
//   final cinemaTable = getCinemaTable(table);
//   switch (cinemaTable) {
//     case CinemaTable.session:
//     return Future.value("test");
//   }
// }

final Map<String, Map<String, StateNotifierProvider>> cinemaProviders = {
  "cinema": {
    "session": sessionListProvider
  }
};