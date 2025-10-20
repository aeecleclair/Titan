import 'package:http/http.dart' as http;
import 'package:titan/tools/logs/logger.dart';
import 'dart:convert';
import 'package:titan/centralassociation/class/asso.dart';

class AssoRepository {
  static const String host = "https://assos.myecl.fr/assos_links.json";
  final Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };

  static final Logger logger = Logger();
  void initLogger() {
    logger.init();
  }

  Future<List<Asso>> getAssoList() async {
    try {
      final response = await http.get(Uri.parse(host), headers: headers);
      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          final test = data.map<Asso>((asso) => Asso.fromJson(asso)).toList();
          return test;
        } catch (e) {
          logger.error("GET $host\nError while decoding response");
          return <Asso>[];
        }
      } else {
        logger.error("GET $host\n${response.statusCode} ${response.body}");
        return <Asso>[];
      }
    } catch (e) {
      logger.error("GET $host\nError while fetching response");
      return <Asso>[];
    }
  }
}
