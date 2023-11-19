// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/admin/providers/admin_page_provider.dart';

void main() {
  group('AdminPageNotifier', () {
    test('initial state should be AdminPage.main', () {
      final adminPageNotifier = AdminPageNotifier();
      expect(adminPageNotifier.state, AdminPage.main);
    });

    test('setAdminPage should update state', () {
      final adminPageNotifier = AdminPageNotifier();
      adminPageNotifier.setAdminPage(AdminPage.addAsso);
      expect(adminPageNotifier.state, AdminPage.addAsso);
    });
  });
}
