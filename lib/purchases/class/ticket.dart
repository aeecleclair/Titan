import 'package:titan/purchases/class/product_variant.dart';
import 'package:titan/purchases/class/user_ticket.dart';
import 'package:titan/tools/functions.dart';

class Ticket {
  Ticket({
    required this.id,
    required this.productVariant,
    required this.user,
    required this.scanLeft,
    required this.tags,
    required this.expirationDate,
    required this.name,
    this.qrCodeSecret = "",
  });

  late final String id;
  late final ProductVariant productVariant;
  late final UserTicket user;
  late final int scanLeft;
  late final List<String> tags;
  late final DateTime expirationDate;
  late final String name;
  late final String qrCodeSecret;

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productVariant = ProductVariant.fromJson(json['product_variant']);
    user = UserTicket.fromJson(json['user']);
    scanLeft = json['scan_left'];
    tags = json['tags'].toString().split(";");
    expirationDate = processDateFromAPI(json['expiration']);
    name = json['name'];
    qrCodeSecret = "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'product_variant': productVariant.toJson(),
      'user': user.toJson(),
      'scan_left': scanLeft,
      'tags': tags.join(";"),
      'expiration': processDateToAPI(expirationDate),
      'name': name,
      'qr_code_secret': qrCodeSecret,
    };
    return data;
  }

  Ticket copyWith({
    String? id,
    ProductVariant? productVariant,
    UserTicket? user,
    int? scanLeft,
    List<String>? tags,
    DateTime? expirationDate,
    String? name,
    String? qrCodeSecret,
  }) {
    return Ticket(
      id: id ?? this.id,
      productVariant: productVariant ?? this.productVariant,
      user: user ?? this.user,
      scanLeft: scanLeft ?? this.scanLeft,
      tags: tags ?? this.tags,
      expirationDate: expirationDate ?? this.expirationDate,
      name: name ?? this.name,
      qrCodeSecret: qrCodeSecret ?? this.qrCodeSecret,
    );
  }

  Ticket.empty() {
    id = "";
    productVariant = ProductVariant.empty();
    user = UserTicket.empty();
    scanLeft = 0;
    tags = [];
    expirationDate = DateTime.now();
    name = "";
    qrCodeSecret = "";
  }

  @override
  String toString() {
    return 'Ticket(id: $id, productVariant: $productVariant, user: $user, scan: $scanLeft, tags: $tags, expirationDate: $expirationDate, name: $name, qrCodeSecret: $qrCodeSecret)';
  }
}
