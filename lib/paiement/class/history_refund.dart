import 'package:titan/tools/functions.dart';

class HistoryRefund {
  final int total;
  final DateTime creation;

  HistoryRefund({required this.total, required this.creation});

  HistoryRefund.fromJson(Map<String, dynamic> json)
    : total = json['total'],
      creation = processDateFromAPI(json['creation']);

  Map<String, dynamic> toJson() => {
    'total': total,
    'creation': processDateToAPI(creation),
  };

  @override
  String toString() {
    return 'HistoryRefund {total: $total, creation: $creation}';
  }

  HistoryRefund.empty() : total = 0, creation = DateTime.now();

  HistoryRefund copyWith({int? total, DateTime? creation}) {
    return HistoryRefund(
      total: total ?? this.total,
      creation: creation ?? this.creation,
    );
  }
}
