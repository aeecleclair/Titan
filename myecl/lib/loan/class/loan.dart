import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/functions.dart';

class Loan {
  Loan({
    required this.id,
    required this.borrowerId,
    required this.notes,
    required this.start,
    required this.end,
    required this.association,
    required this.caution,
    required this.items
  });
  late final String id;
  late final String borrowerId;
  late final String notes;
  late final DateTime start;
  late final DateTime end;
  late final String association;
  late final bool caution;
  late final List<Item> items;

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    borrowerId = json['borrower_id'];
    notes = json['notes'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    association = json['association'];
    caution = json['caution'];
    items = List<Item>.from(json['items'].map((x) => Item.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['borrower_id'] = borrowerId;
    _data['notes'] = notes;
    _data['start'] = processDate(start);
    _data['end'] = processDate(end);
    _data['association'] = association;
    _data['caution'] = caution;
    _data['items'] = items.map((x) => x.toJson()).toList();
    return _data;
  }

  Loan copyWith({id, borrowerId, notes, start, end, association, caution, items}) {
    return Loan(
        id: id ?? this.id,
        borrowerId: borrowerId ?? this.borrowerId,
        notes: notes ?? this.notes,
        start: start ?? this.start,
        end: end ?? this.end,
        association: association ?? this.association,
        caution: caution ?? this.caution,
        items: items ?? this.items);
  }
}
