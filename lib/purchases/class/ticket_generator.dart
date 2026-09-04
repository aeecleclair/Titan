import 'package:titan/tools/functions.dart';

class TicketGenerator {
  TicketGenerator({
    required this.id,
    required this.name,
    required this.maxUse,
    required this.expiration,
    this.scanCount,
  });

  late final String id;
  late final String name;
  late final int maxUse;
  late final DateTime expiration;
  late final int? scanCount;

  TicketGenerator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    maxUse = json['max_use'];
    expiration = processDateFromAPI(json['expiration']);
    scanCount = json['scan_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'max_use': maxUse,
      'expiration': processDateToAPI(expiration),
      'scan_count': scanCount,
    };
    return data;
  }

  TicketGenerator copyWith({
    String? id,
    String? name,
    int? maxUse,
    DateTime? expiration,
    int? scanCount,
  }) {
    return TicketGenerator(
      id: id ?? this.id,
      name: name ?? this.name,
      maxUse: maxUse ?? this.maxUse,
      expiration: expiration ?? this.expiration,
      scanCount: scanCount ?? this.scanCount,
    );
  }

  TicketGenerator.empty() {
    id = "";
    name = "";
    maxUse = 0;
    expiration = DateTime.now();
    scanCount = null;
  }

  @override
  String toString() {
    return 'TicketGenerator(id: $id, name: $name, maxUse: $maxUse, expiration: $expiration, scanCount: $scanCount)';
  }
}
