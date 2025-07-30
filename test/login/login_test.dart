import 'package:flutter_test/flutter_test.dart';
import 'package:titan/login/class/account_type.dart';
import 'package:titan/login/tools/functions.dart';

void main() {
  group('Account Type Utils', () {
    test('Account Type to ID - Student', () {
      expect(
        accountTypeToID(AccountType.student),
        '39691052-2ae5-4e12-99d0-7a9f5f2b0136',
      );
    });

    test('Account Type to ID - Staff', () {
      expect(
        accountTypeToID(AccountType.staff),
        '703056c4-be9d-475c-aa51-b7fc62a96aaa',
      );
    });

    test('Account Type to ID - Admin', () {
      expect(
        accountTypeToID(AccountType.admin),
        '0a25cb76-4b63-4fd3-b939-da6d9feabf28',
      );
    });

    test('Account Type to ID - Association', () {
      expect(
        accountTypeToID(AccountType.association),
        '29751438-103c-42f2-b09b-33fbb20758a7',
      );
    });
  });
}
