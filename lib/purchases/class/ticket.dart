import 'package:myecl/purchases/class/product_variant.dart';
import 'package:myecl/tools/functions.dart';

class Ticket {
  Ticket({
    required this.id,
    required this.productVariant,
    required this.userId,
    required this.scanLeft,
    required this.tags,
    required this.expirationDate,
    this.qrCodeSecret = "",
  });

  late final String id;
  late final ProductVariant productVariant;
  late final String userId;
  late final int scanLeft;
  late final List<String> tags;
  late final DateTime expirationDate;
  late final String qrCodeSecret;

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productVariant = ProductVariant.fromJson(json['product_variant']);
    userId = json['user_id'];
    scanLeft = json['scan_left'];
    tags = json['tags'].toString().split(";");
    expirationDate = processDateFromAPI(json['expiration']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'product_variant': productVariant.toJson(),
      'user_id': userId,
      'scan_left': scanLeft,
      'tags': tags.join(";"),
      'expiration': processDateToAPI(expirationDate),
      'qr_code_secret': qrCodeSecret,
    };
    return data;
  }

  Ticket copyWith({
    String? id,
    ProductVariant? productVariant,
    String? userId,
    int? scanLeft,
    List<String>? tags,
    DateTime? expirationDate,
    String? qrCodeSecret,
  }) {
    return Ticket(
      id: id ?? this.id,
      productVariant: productVariant ?? this.productVariant,
      userId: userId ?? this.userId,
      scanLeft: scanLeft ?? this.scanLeft,
      tags: tags ?? this.tags,
      expirationDate: expirationDate ?? this.expirationDate,
      qrCodeSecret: qrCodeSecret ?? this.qrCodeSecret,
    );
  }

  Ticket.empty() {
    id = "";
    productVariant = ProductVariant.empty();
    userId = "";
    scanLeft = 0;
    tags = [];
    expirationDate = DateTime.now();
    qrCodeSecret = "";
  }

  @override
  String toString() {
    return 'Ticket(id: $id, productVariant: $productVariant, userId: $userId, scan: $scanLeft, tags: $tags, expirationDate: $expirationDate, qrCodeSecret: $qrCodeSecret)';
  }
}
