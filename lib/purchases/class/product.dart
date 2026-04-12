import 'package:titan/purchases/class/ticket_generator.dart';

class Product {
  Product({
    required this.id,
    required this.nameFR,
    required this.nameEN,
    required this.descriptionFR,
    required this.descriptionEN,
    required this.ticketGenerators,
    required this.year,
  });

  late final String id;
  late final String nameFR;
  late final String? nameEN;
  late final String? descriptionFR;
  late final String? descriptionEN;
  late final List<TicketGenerator> ticketGenerators;
  late final int year;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameFR = json['name_fr'];
    nameEN = json['name_en'];
    descriptionFR = json['description_fr'] ?? "";
    descriptionEN = json['description_en'] ?? "";
    ticketGenerators = List<TicketGenerator>.from(
      (json['tickets'] as List).map((x) => TicketGenerator.fromJson(x)),
    );
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name_fr': nameFR,
      'name_en': nameEN,
      'description_fr': descriptionFR,
      'description_en': descriptionEN,
      'tickets': ticketGenerators.map((x) => x.toJson()).toList(),
      'year': year,
    };
    return data;
  }

  Product copyWith({
    String? id,
    String? nameFR,
    String? nameEN,
    String? descriptionFR,
    String? descriptionEN,
    List<TicketGenerator>? ticketGenerators,
    int? year,
  }) {
    return Product(
      id: id ?? this.id,
      nameFR: nameFR ?? this.nameFR,
      nameEN: nameEN ?? this.nameEN,
      descriptionFR: descriptionFR ?? this.descriptionFR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
      ticketGenerators: ticketGenerators ?? this.ticketGenerators,
      year: year ?? this.year,
    );
  }

  Product.empty() {
    id = "";
    nameFR = "";
    nameEN = "";
    descriptionFR = "";
    descriptionEN = "";
    ticketGenerators = [];
    year = 1970;
  }

  @override
  String toString() {
    return 'Product(id: $id, nameFR: $nameFR, nameEN: $nameEN, descriptionFR: $descriptionFR, descriptionEN: $descriptionEN, ticketGenerators: $ticketGenerators, year: $year)';
  }
}
