import 'package:titan/tools/functions.dart';

class Session {
  Session({
    required this.id,
    required this.name,
    required this.startDatetime,
    this.quota,
    this.disabled = false,
    this.ticketsInCheckout = 0,
    this.ticketsSold = 0,
    this.soldOut = false,
  });
  late final String id;
  late final String name;
  late final DateTime startDatetime;
  late final int? quota;
  late final bool disabled;
  late final int ticketsInCheckout;
  late final int ticketsSold;
  late final bool soldOut;

  bool get hasSales => ticketsInCheckout + ticketsSold > 0;

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    startDatetime = processDateFromAPI(json['start_datetime'] ?? '');
    quota = json['quota'];
    disabled = json['disabled'] ?? false;
    ticketsInCheckout = (json['tickets_in_checkout'] as num?)?.toInt() ?? 0;
    ticketsSold = (json['tickets_sold'] as num?)?.toInt() ?? 0;
    soldOut = json['sold_out'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_datetime'] = processDateToAPI(startDatetime);
    data['quota'] = quota;
    data['disabled'] = disabled;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      'start_datetime': processDateToAPI(startDatetime),
      'quota': quota,
    };
  }

  Session copyWith({
    String? id,
    String? name,
    DateTime? startDatetime,
    int? quota,
    bool? disabled,
    int? ticketsInCheckout,
    int? ticketsSold,
    bool? soldOut,
  }) {
    return Session(
      id: id ?? this.id,
      name: name ?? this.name,
      startDatetime: startDatetime ?? this.startDatetime,
      quota: quota ?? this.quota,
      disabled: disabled ?? this.disabled,
      ticketsInCheckout: ticketsInCheckout ?? this.ticketsInCheckout,
      ticketsSold: ticketsSold ?? this.ticketsSold,
      soldOut: soldOut ?? this.soldOut,
    );
  }

  Session.empty() {
    id = '';
    name = '';
    startDatetime = DateTime.now();
    quota = null;
    disabled = false;
    ticketsInCheckout = 0;
    ticketsSold = 0;
    soldOut = false;
  }

  @override
  String toString() {
    return 'Session{id : $id, name: $name, startDatetime: $startDatetime, quota: $quota, soldOut: $soldOut, disabled: $disabled}';
  }
}
