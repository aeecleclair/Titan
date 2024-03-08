import 'package:myecl/loan/class/item_quantity.dart';
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
    required this.itemsQuantity,
    required this.returned,
  });
  late final String id;
  late final Loaner loaner;
  late final SimpleUser borrower;
  late final String notes;
  late final DateTime start;
  late final DateTime end;
  late final String caution;
  late final List<ItemQuantity> itemsQuantity;
  late final bool returned;

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    borrower = SimpleUser.fromJson(json['borrower'] as Map<String, dynamic>);
    loaner = Loaner.fromJson(json['loaner'] as Map<String, dynamic>);
    notes = json['notes'] as String;
    start = DateTime.parse(json['start'] as String);
    end = DateTime.parse(json['end'] as String);
    caution = json['caution'] as String;
    itemsQuantity = List<ItemQuantity>.from(
        (json['items_qty'] as List<Map<String, dynamic>>)
            .map((x) => ItemQuantity.fromJson(x)));
    returned = json['returned'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['borrower_id'] = borrower.id;
    data['loaner_id'] = loaner.id;
    data['notes'] = notes;
    data['start'] = processDateToAPIWithoutHour(start);
    data['end'] = processDateToAPIWithoutHour(end);
    data['caution'] = caution;
    data['items_borrowed'] = itemsQuantity.map((x) => x.toJson()).toList();
    return data;
  }

  Loan copyWith(
      {String? id,
      Loaner? loaner,
      SimpleUser? borrower,
      String? notes,
      DateTime? start,
      DateTime? end,
      String? caution,
      List<ItemQuantity>? itemsQuantity,
      bool? returned}) {
    return Loan(
        id: id ?? this.id,
        loaner: loaner ?? this.loaner,
        borrower: borrower ?? this.borrower,
        notes: notes ?? this.notes,
        start: start ?? this.start,
        end: end ?? this.end,
        caution: caution ?? this.caution,
        itemsQuantity: itemsQuantity ?? this.itemsQuantity,
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
    itemsQuantity = [];
    returned = false;
  }

  @override
  String toString() {
    return 'Loan(id: $id, loaner: $loaner, borrower: $borrower, notes: $notes, start: $start, end: $end, caution: $caution, itemsQuantity: $itemsQuantity, returned: $returned)';
  }
}
