import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profil.dart';
import 'parser.dart';

class ProfilProvider {

  static const url = '/elocaps';

  Future<Profil> getProfil(String id) async {
    var resp = await http.get(Uri.parse('$url/$id'),
        headers: {'Content-Type': 'application/json'});
    return parseProfil(resp.body);
  }

  Future<int> createProfil(Profil profil) async {
    var resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profil.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editProfil(Profil profil) async {
    var resp = await http.put(
      Uri.parse('$url/${profil.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profil.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteProfil(String id) async {
    var resp = await http.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<int> getProfilRank(String id) async {
    var profil = await getProfil(id);
    return profil.rank ?? -1;
  }

  Future<int> getProfilElo(String id) async {
    var profil = await getProfil(id);
    return profil.elo ?? -1;
  }
}