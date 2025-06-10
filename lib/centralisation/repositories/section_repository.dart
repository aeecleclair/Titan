import 'package:titan/centralisation/class/section.dart';
import 'package:http/http.dart' as http;
import 'package:titan/tools/logs/logger.dart';
import 'dart:convert';

class SectionRepository {
  static const String host = "https://centralisation.myecl.fr/links.json";
  final Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };

  static final Logger logger = Logger();
  void initLogger() {
    logger.init();
  }

  Future<List<Section>> getSectionList() async {
    try {
      final response = await http.get(Uri.parse(host), headers: headers);
      if (response.statusCode == 200) {
        try {
          String toDecode = utf8.decode(response.bodyBytes);
          final data = jsonDecode(toDecode) as Map<String, dynamic>;
          return data
              .map((key, value) => MapEntry(key, Section.fromJson(key, value)))
              .values
              .toList();
        } catch (e) {
          logger.error("GET $host\nError while decoding response");
          return <Section>[];
        }
      } else {
        logger.error("GET $host\n${response.statusCode} ${response.body}");
        return <Section>[];
      }
    } catch (e) {
      logger.error("GET $host\nError while fetching response");
      return <Section>[];
    }
  }
}
