import 'dart:convert';

import '../models/game.dart';
import '../models/profil.dart';

Profil parseProfil(String jsonString) {
  final parsed = json.decode(jsonString);
  return Profil.fromJson(parsed);
}


Game parseGame(String body) {
  final parsed = json.decode(body);
  return Game.fromJson(parsed);
}
