import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';

void main() {
  group('PretendanceNotifier', () {
    test('setId should update the state', () {
      final container = ProviderContainer();
      final notifier = container.read(pretendanceProvider.notifier);

      final pretendance = Pretendance.empty().copyWith(
        id: '123',
        name: 'John Doe',
      );

      notifier.setId(pretendance);

      expect(container.read(pretendanceProvider).id, '123');
      expect(container.read(pretendanceProvider).name, 'John Doe');
    });
  });
}
