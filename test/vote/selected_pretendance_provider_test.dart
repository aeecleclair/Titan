// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/selected_pretendance_provider.dart';

void main() {
  group('SelectedPretendanceProvider', () {
    test('changeSelection should update state', () {
      final provider = SelectedPretendanceProvider();
      final newSelection =
          Pretendance.empty().copyWith(id: '1', name: 'John Doe');
      provider.changeSelection(newSelection);
      expect(provider.state, newSelection);
    });

    test('clear should set state to empty', () {
      final pretendance = Pretendance.empty();
      final provider = SelectedPretendanceProvider();
      final newSelection =
          Pretendance.empty().copyWith(id: '1', name: 'John Doe');
      provider.changeSelection(newSelection);
      provider.clear();
      expect(provider.state.id, pretendance.id);
    });

    test('initial state should be empty', () {
      final pretendance = Pretendance.empty();
      final provider = SelectedPretendanceProvider();
      expect(provider.state.id, pretendance.id);
    });
  });
}
