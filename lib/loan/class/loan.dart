import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class Loan {
  Loan({
    required this.id,
    required this.loaner,
    required this.borrower,
    required this.notes,
    required this.start,
    required this.end,
    required this.caution,
    required this.items,
    required this.returned,
  });
  late final String id;
  late final Loaner loaner;
  late final SimpleUser borrower;
  late final String notes;
  late final DateTime start;
  late final DateTime end;
  late final String caution;
  late final List<Item> items;
  late final bool returned;

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    borrower = SimpleUser.fromJson(json['borrower']);
    loaner = Loaner.fromJson(json['loaner']);
    notes = json['notes'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    caution = json['caution'];
    items = List<Item>.from(json['items'].map((x) => Item.fromJson(x)));
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['borrower_id'] = borrower.id;
    data['loaner_id'] = loaner.id;
    data['notes'] = notes;
    data['start'] = processDateToAPIWitoutHour(start);
    data['end'] = processDateToAPIWitoutHour(end);
    data['caution'] = caution;
    data['item_ids'] = items.map((x) => x.id).toList();
    return data;
  }

  Loan copyWith({id, loaner, borrower, notes, start, end, caution, items, returned}) {
    return Loan(
        id: id ?? this.id,
        loaner: loaner ?? this.loaner,
        borrower: borrower ?? this.borrower,
        notes: notes ?? this.notes,
        start: start ?? this.start,
        end: end ?? this.end,
        caution: caution ?? this.caution,
        items: items ?? this.items,
        returned: returned ?? this.returned);
  }

  Loan.empty() {
    id = '';
    borrower = SimpleUser.empty();
    loaner = Loaner.empty();
    notes = '';
    start = DateTime.now();
    end = DateTime.now();
    caution = '';
    items = [];
    returned = false;
  }

  @override
  String toString() {
    return 'Loan(id: $id, loaner: $loaner, borrower: $borrower, notes: $notes, start: $start, end: $end, caution: $caution, items: $items, returned: $returned)';
  }
}
