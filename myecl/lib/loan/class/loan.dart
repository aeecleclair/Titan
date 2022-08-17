import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class Loan {
  Loan({
    required this.id,
    required this.loanerId,
    required this.borrowerId,
    required this.notes,
    required this.start,
    required this.end,
    required this.caution,
    required this.items,
  });
  late final String id;
  late final String loanerId;
  late final String borrowerId;
  late final String notes;
  late final DateTime start;
  late final DateTime end;
  late final bool caution;
  late final List<Item> items;

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    borrowerId = json['borrower_id'];
    loanerId = json['loaner_id'];
    notes = json['notes'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    caution = json['caution'];
    items = List<Item>.from(json['items'].map((x) => Item.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['borrower_id'] = borrowerId;
    _data['loaner_id'] = loanerId;
    _data['notes'] = notes;
    _data['start'] = processDateToAPI(start);
    _data['end'] = processDateToAPI(end);
    _data['caution'] = caution;
    _data['item_ids'] = items.map((x) => x.id).toList();
    return _data;
  }

  Loan copyWith({id, loanerId, borrowerId, notes, start, end, caution, items}) {
    return Loan(
        id: id ?? this.id,
        loanerId: loanerId ?? this.loanerId,
        borrowerId: borrowerId ?? this.borrowerId,
        notes: notes ?? this.notes,
        start: start ?? this.start,
        end: end ?? this.end,
        caution: caution ?? this.caution,
        items: items ?? this.items);
  }
}
