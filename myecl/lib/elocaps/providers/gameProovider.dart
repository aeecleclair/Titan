import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';
import 'parser.dart';

class GameProvider {

  static const url = '/games';

  Future<Game> getGame(String id) async {
    var resp = await http.get(Uri.parse('$url/$id'),
        headers: {'Content-Type': 'application/json'});
    return parseGame(resp.body);
  }

  Future<int> createGame(Game game) async {
    var resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(game.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editGame(Game game) async {
    var resp = await http.put(
      Uri.parse('$url/${game.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(game.toJson()),
    );
    return resp.statusCode;
  }
}