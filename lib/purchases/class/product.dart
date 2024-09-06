import 'package:myecl/purchases/class/generated_ticket.dart';

class Product {
  Product({
    required this.id,
    required this.nameFR,
    required this.nameEN,
    required this.descriptionFR,
    required this.descriptionEN,
    required this.tickets,
  });

  late final String id;
  late final String nameFR;
  late final String? nameEN;
  late final String? descriptionFR;
  late final String? descriptionEN;
  late final List<GeneratedTicket> tickets;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameFR = json['name_fr'];
    nameEN = json['name_en'];
    descriptionFR = json['description_fr'] ?? "";
    descriptionEN = json['description_en'] ?? "";
    tickets = List<GeneratedTicket>.from(
      (json['tickets'] as List).map((x) => GeneratedTicket.fromJson(x)),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name_fr': nameFR,
      'name_en': nameEN,
      'description_fr': descriptionFR,
      'description_en': descriptionEN,
      'tickets': tickets.map((x) => x.toJson()).toList(),
    };
    return data;
  }

  Product copyWith({
    String? id,
    String? nameFR,
    String? nameEN,
    String? descriptionFR,
    String? descriptionEN,
    List<GeneratedTicket>? tickets,
  }) {
    return Product(
      id: id ?? this.id,
      nameFR: nameFR ?? this.nameFR,
      nameEN: nameEN ?? this.nameEN,
      descriptionFR: descriptionFR ?? this.descriptionFR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
      tickets: tickets ?? this.tickets,
    );
  }

  Product.empty() {
    id = "";
    nameFR = "";
    nameEN = "";
    descriptionFR = "";
    descriptionEN = "";
    tickets = [];
  }

  @override
  String toString() {
    return 'Product(id: $id, nameFR: $nameFR, nameEN: $nameEN, descriptionFR: $descriptionFR, descriptionEN: $descriptionEN, tickets: $tickets)';
  }
}
