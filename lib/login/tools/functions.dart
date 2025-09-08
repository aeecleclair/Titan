import 'package:titan/login/class/account_type.dart';

String accountTypeToID(AccountType type) {
  switch (type) {
    case AccountType.student:
      return '39691052-2ae5-4e12-99d0-7a9f5f2b0136';
    case AccountType.formerstudent:
      return 'ab4c7503-41b3-11ee-8177-089798f1a4a5';
    case AccountType.staff:
      return '703056c4-be9d-475c-aa51-b7fc62a96aaa';
    case AccountType.admin:
      return '0a25cb76-4b63-4fd3-b939-da6d9feabf28';
    case AccountType.association:
      return '29751438-103c-42f2-b09b-33fbb20758a7';
  }
}
