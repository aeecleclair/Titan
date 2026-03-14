import 'package:titan/tools/functions.dart';

class Shotgun {
  Shotgun({required this.id, required this.date, required this.prices});
  late final String id;
  late final DateTime date;
  late final Map<String, String> prices;

  Shotgun.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = processDateFromAPI(json['date']);
    prices = json['prices'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = processDateToAPI(date);
    data['prices'] = prices;
    return data;
  }

  Shotgun copyWith({String? id, DateTime? date, Map<String, String>? prices}) {
    return Shotgun(
      id: id ?? this.id,
      date: date ?? this.date,
      prices: prices ?? this.prices,
    );
  }

  Shotgun.empty() {
    id = '';
    date = DateTime.now();
    prices = {};
  }

  @override
  String toString() {
    return 'Shotgun{id : $id, date: $date, prices: $prices}';
  }
}
