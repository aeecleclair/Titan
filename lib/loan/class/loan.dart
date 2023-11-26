import 'package:myecl/generated/openapi.models.swagger.dart' show CoreUserSimple;
import 'package:myecl/loan/class/item_quantity.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/tools/functions.dart';

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
  late final CoreUserSimple borrower;
  late final String notes;
  late final DateTime start;
  late final DateTime end;
  late final String caution;
  late final List<ItemQuantity> itemsQuantity;
  late final bool returned;

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    borrower = CoreUserSimple.fromJson(json['borrower']);
    loaner = Loaner.fromJson(json['loaner']);
    notes = json['notes'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    caution = json['caution'];
    itemsQuantity = List<ItemQuantity>.from(
        json['items_qty'].map((x) => ItemQuantity.fromJson(x)));
    returned = json['returned'];
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
      CoreUserSimple? borrower,
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
    borrower = CoreUserSimple.fromJson({});
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
