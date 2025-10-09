import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

class Loan {
  final String id;
  final Loaner loaner;
  final SimpleUser borrower;
  final String notes;
  final DateTime start;
  final DateTime end;
  final String caution;
  final List<ItemQuantity> itemsQuantity;
  final bool returned;
  final DateTime? returnedDate;

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
    this.returnedDate,
  });

  Loan.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      borrower = SimpleUser.fromJson(json['borrower']),
      loaner = Loaner.fromJson(json['loaner']),
      notes = json['notes'],
      start = processDateFromAPIWithoutHour(json['start']),
      end = processDateFromAPIWithoutHour(json['end']),
      caution = json['caution'],
      itemsQuantity = List<ItemQuantity>.from(
        json['items_qty'].map((x) => ItemQuantity.fromJson(x)),
      ),
      returned = json['returned'],
      returnedDate = json['returned_date'] != null
          ? DateTime.parse(json['returned_date'])
          : null;

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
    data['returned_date'] = returnedDate != null
        ? processDateToAPIWithoutHour(returnedDate!)
        : null;
    return data;
  }

  Loan copyWith({
    String? id,
    Loaner? loaner,
    SimpleUser? borrower,
    String? notes,
    DateTime? start,
    DateTime? end,
    String? caution,
    List<ItemQuantity>? itemsQuantity,
    bool? returned,
    DateTime? returnedDate,
  }) {
    return Loan(
      id: id ?? this.id,
      loaner: loaner ?? this.loaner,
      borrower: borrower ?? this.borrower,
      notes: notes ?? this.notes,
      start: start ?? this.start,
      end: end ?? this.end,
      caution: caution ?? this.caution,
      itemsQuantity: itemsQuantity ?? this.itemsQuantity,
      returned: returned ?? this.returned,
      returnedDate: returnedDate ?? this.returnedDate,
    );
  }

  Loan.empty()
    : id = '',
      borrower = SimpleUser.empty(),
      loaner = Loaner.empty(),
      notes = '',
      start = DateTime.now(),
      end = DateTime.now(),
      caution = '',
      itemsQuantity = [],
      returned = false,
      returnedDate = null;

  @override
  String toString() {
    return 'Loan(id: $id, loaner: $loaner, borrower: $borrower, notes: $notes, start: $start, end: $end, caution: $caution, itemsQuantity: $itemsQuantity, returned: $returned, returnedDate: $returnedDate)';
  }
}
