import 'package:flutter_test/flutter_test.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/loan/class/item_simple.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/user/class/simple_users.dart';

void main() {
  group('Testing Item class', () {
    test('Should return an item', () {
      final item = Item.empty();
      expect(item, isA<Item>());
    });

    test('Should return an item with the right values', () {
      final item = Item(
        id: '1',
        name: 'name',
        caution: 1,
        totalQuantity: 1,
        loanedQuantity: 1,
        suggestedLendingDuration: 1,
      );
      expect(item.id, '1');
      expect(item.name, 'name');
      expect(item.caution, 1);
      expect(item.totalQuantity, 1);
      expect(item.loanedQuantity, 1);
      expect(item.suggestedLendingDuration, 1);
    });

    test('Should update with new values', () {
      final item = Item.empty();
      Item newItem = item.copyWith(id: '2');
      expect(newItem.id, '2');
      newItem = item.copyWith(name: 'name2');
      expect(newItem.name, 'name2');
      newItem = item.copyWith(caution: 2);
      expect(newItem.caution, 2);
      newItem = item.copyWith(totalQuantity: 1);
      expect(newItem.totalQuantity, 1);
      newItem = item.copyWith(loanedQuantity: 1);
      expect(newItem.loanedQuantity, 1);
      newItem = item.copyWith(suggestedLendingDuration: 2);
      expect(newItem.suggestedLendingDuration, 2.0);
    });

    test('Should print properly', () {
      final item = Item(
        id: '1',
        name: 'name',
        caution: 1,
        totalQuantity: 1,
        loanedQuantity: 1,
        suggestedLendingDuration: 1,
      );
      expect(
        item.toString(),
        'Item(id: 1, name: name, caution: 1, totalQuantity: 1, loanedQuantity: 1, suggestedLendingDuration: 1)',
      );
    });

    test('Should parse an item from json', () {
      final item = Item.fromJson({
        'id': '1',
        'name': 'name',
        'suggested_caution': 1,
        'total_quantity': 1,
        'loaned_quantity': 1,
        'suggested_lending_duration': 1,
      });
      expect(item.id, '1');
      expect(item.name, 'name');
      expect(item.caution, 1);
      expect(item.totalQuantity, 1);
      expect(item.loanedQuantity, 1);
      expect(item.suggestedLendingDuration, 1.0);
    });

    test('Should return correct json', () {
      final item = Item(
        id: '1',
        name: 'name',
        caution: 1,
        totalQuantity: 1,
        loanedQuantity: 1,
        suggestedLendingDuration: 1,
      );
      expect(item.toJson(), {
        'id': '1',
        'name': 'name',
        'suggested_caution': 1,
        'total_quantity': 1,
        'loaned_quantity': 1,
        'suggested_lending_duration': 1.0,
      });
    });
  });

  group('Testing Loan class', () {
    test('Should return a loan', () {
      final loan = Loan.empty();
      expect(loan, isA<Loan>());
    });

    test('Should return a loan with the right values', () {
      final loan = Loan(
        id: '1',
        itemsQuantity: [
          ItemQuantity(
            itemSimple: ItemSimple(id: '1', name: 'name'),
            quantity: 2,
          ),
        ],
        borrower: SimpleUser(
          id: '1',
          accountType: AccountType(type: 'external'),
          name: 'name',
          firstname: '',
          nickname: '',
        ),
        returned: true,
        caution: '',
        end: DateTime.now(),
        loaner: Loaner.empty(),
        notes: '',
        start: DateTime.now(),
      );
      expect(loan.id, '1');
      expect(loan.itemsQuantity[0].itemSimple.id, '1');
      expect(loan.borrower.id, '1');
      expect(loan.returned, true);
    });

    test('Should update with new values', () {
      final loan = Loan.empty();
      Loan newLoan = loan.copyWith(id: '2');
      expect(newLoan.id, '2');
      newLoan = loan.copyWith(
        itemsQuantity: [
          ItemQuantity(
            itemSimple: ItemSimple(id: '2', name: 'name'),
            quantity: 2,
          ),
        ],
      );
      expect(newLoan.itemsQuantity[0].itemSimple.id, '2');
      newLoan = loan.copyWith(
        borrower: SimpleUser(
          id: '2',
          accountType: AccountType(type: 'external'),
          name: 'name2',
          firstname: '',
          nickname: '',
        ),
      );
      expect(newLoan.borrower.id, '2');
      newLoan = loan.copyWith(returned: false);
      expect(newLoan.returned, false);
      newLoan = loan.copyWith(caution: '2');
      expect(newLoan.caution, '2');
      newLoan = loan.copyWith(end: DateTime.parse('2020-01-01'));
      expect(newLoan.end, DateTime.parse('2020-01-01'));
      newLoan = loan.copyWith(
        loaner: Loaner(id: '2', name: 'name2', groupManagerId: ''),
      );
      expect(newLoan.loaner.id, '2');
      newLoan = loan.copyWith(notes: 'notes');
      expect(newLoan.notes, 'notes');
      newLoan = loan.copyWith(start: DateTime.parse('2020-01-01'));
      expect(newLoan.start, DateTime.parse('2020-01-01'));
      newLoan = loan.copyWith(borrower: SimpleUser.empty().copyWith(id: '2'));
      expect(newLoan.borrower.id, '2');
    });

    test('Should print properly', () {
      final loan = Loan(
        id: '1',
        itemsQuantity: [
          ItemQuantity(
            itemSimple: ItemSimple(id: '1', name: 'name'),
            quantity: 2,
          ),
        ],
        borrower: SimpleUser(
          id: '1',
          accountType: AccountType(type: 'external'),
          name: 'name',
          firstname: '',
          nickname: '',
        ),
        returned: true,
        returnedDate: DateTime.parse('2020-01-01'),
        caution: '',
        end: DateTime.parse('2020-01-01'),
        loaner: Loaner.empty(),
        notes: '',
        start: DateTime.parse('2020-01-01'),
      );
      expect(
        loan.toString(),
        'Loan(id: 1, loaner: Loaner(name: , groupManagerId: , id: ), borrower: SimpleUser {name: name, firstname: , nickname: , id: 1, accountType: external}, notes: , start: 2020-01-01 00:00:00.000, end: 2020-01-01 00:00:00.000, caution: , itemsQuantity: [ItemQuantity(itemSimple: ItemSimple(id: 1, name: name, quantity: 2)], returned: true, returnedDate: 2020-01-01 00:00:00.000)',
      );
    });

    test('Should parse a loan from json', () {
      final loan = Loan.fromJson({
        'id': '1',
        'items_qty': [
          {
            'itemSimple': {
              'id': '1',
              'name': 'name',
              'suggested_caution': 1,
              'total_quantity': 1,
              'loaned_quantity': 1,
              'suggested_lending_duration': 1.0,
            },
            'quantity': 2,
          },
        ],
        'borrower': {
          'id': '1',
          'name': 'name',
          'firstname': '',
          'nickname': '',
          'account_type': 'external',
        },
        'returned': true,
        'caution': '',
        'end': DateTime.now().toString(),
        'loaner': {'id': '', 'name': '', 'group_manager_id': ''},
        'notes': '',
        'start': DateTime.now().toString(),
      });
      expect(loan.id, '1');
      expect(loan.itemsQuantity[0].itemSimple.id, '1');
      expect(loan.borrower.id, '1');
      expect(loan.returned, true);
      expect(loan.caution, '');
      expect(loan.loaner.id, '');
      expect(loan.notes, '');
    });

    test('Should return correct json', () {
      final loan = Loan(
        id: '1',
        itemsQuantity: [
          ItemQuantity(
            itemSimple: ItemSimple(id: '1', name: 'name'),
            quantity: 2,
          ),
        ],
        borrower: SimpleUser(
          id: '1',
          accountType: AccountType(type: 'external'),
          name: 'name',
          firstname: '',
          nickname: '',
        ),
        returned: true,
        returnedDate: DateTime.parse('2020-01-01'),
        caution: '',
        end: DateTime.parse('2020-01-01'),
        loaner: Loaner.empty(),
        notes: '',
        start: DateTime.parse('2020-01-01'),
      );
      expect(loan.toJson(), {
        'id': '1',
        'borrower_id': '1',
        'loaner_id': '',
        'notes': '',
        'start': '2020-01-01',
        'end': '2020-01-01',
        'caution': '',
        'items_borrowed': [
          {'item_id': '1', 'quantity': 2},
        ],
        'returned_date': '2020-01-01',
      });
    });
  });

  group('Testing Loaner class', () {
    test('Should create a loaner', () {
      final loaner = Loaner(id: '1', name: 'name', groupManagerId: '1');
      expect(loaner.id, '1');
      expect(loaner.name, 'name');
      expect(loaner.groupManagerId, '1');
    });

    test('Should create an empty loaner', () {
      final loaner = Loaner.empty();
      expect(loaner.id, '');
      expect(loaner.name, '');
      expect(loaner.groupManagerId, '');
    });

    test('Should update with new values', () {
      final loaner = Loaner.empty();
      Loaner newLoaner = loaner.copyWith(id: '2');
      expect(newLoaner.id, '2');
      newLoaner = loaner.copyWith(name: 'name2');
      expect(newLoaner.name, 'name2');
      newLoaner = loaner.copyWith(groupManagerId: '2');
      expect(newLoaner.groupManagerId, '2');
    });

    test('Should print properly', () {
      final loaner = Loaner(id: '1', name: 'name', groupManagerId: '1');
      expect(loaner.toString(), 'Loaner(name: name, groupManagerId: 1, id: 1)');
    });

    test('Should parse a loaner from json', () {
      final loaner = Loaner.fromJson({
        'id': '1',
        'name': 'name',
        'group_manager_id': '1',
      });
      expect(loaner.id, '1');
      expect(loaner.name, 'name');
      expect(loaner.groupManagerId, '1');
    });

    test('Should return correct json', () {
      final loaner = Loaner(id: '1', name: 'name', groupManagerId: '1');
      expect(loaner.toJson(), {
        'id': '1',
        'name': 'name',
        'group_manager_id': '1',
      });
    });
  });
}
