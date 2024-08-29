import 'package:myecl/tools/functions.dart';

class Product {
  Product({
    required this.id,
    required this.nameFR,
    required this.nameEN,
    this.descriptionFR = "",
    this.descriptionEN = "",
    required this.generateTicket,
    required this.ticketMaxUse,
    required this.ticketExpiration,
  });

  late final String id;
  late final String nameFR;
  late final String nameEN;
  late final String descriptionFR;
  late final String descriptionEN;
  late final bool generateTicket;
  late final int? ticketMaxUse;
  late final DateTime? ticketExpiration;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameFR = json['name_fr'];
    nameEN = json['name_en'];
    descriptionFR = json['description_fr'] ?? "";
    descriptionEN = json['description_en'] ?? "";
    generateTicket = json['generate_ticket'];
    ticketMaxUse = json['ticket_max_use'];
    ticketExpiration = json['ticket_expiration'] != null
        ? processDateFromAPI(json['ticket_expiration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name_fr': nameFR,
      'name_en': nameEN,
      'description_fr': descriptionFR,
      'description_en': descriptionEN,
      'generate_ticket': generateTicket,
      'ticket_max_use': ticketMaxUse,
      'ticket_expiration':
          ticketExpiration != null ? processDateToAPI(ticketExpiration!) : null,
    };
    return data;
  }

  Product copyWith({
    String? id,
    String? nameFR,
    String? nameEN,
    String? descriptionFR,
    String? descriptionEN,
    bool? generateTicket,
    int? ticketMaxUse,
    DateTime? ticketExpiration,
  }) {
    return Product(
      id: id ?? this.id,
      nameFR: nameFR ?? this.nameFR,
      nameEN: nameEN ?? this.nameEN,
      descriptionFR: descriptionFR ?? this.descriptionFR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
      generateTicket: generateTicket ?? this.generateTicket,
      ticketMaxUse: ticketMaxUse ?? this.ticketMaxUse,
      ticketExpiration: ticketExpiration ?? this.ticketExpiration,
    );
  }

  Product.empty() {
    id = "";
    nameFR = "";
    nameEN = "";
    descriptionFR = "";
    descriptionEN = "";
    generateTicket = false;
    ticketMaxUse = 0;
    ticketExpiration = DateTime.now();
  }

  @override
  String toString() {
    return 'Product(id: $id, nameFR: $nameFR, nameEN: $nameEN, descriptionFR: $descriptionFR, descriptionEN: $descriptionEN)';
  }
}
