import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/tools/builders/empty_models.dart';

void main() {
  group('EndNotifier', () {
    test('setEnd should update state', () {
      final endNotifier = EndNotifier();
      endNotifier.setEnd('2022-12-31');
      expect(endNotifier.state, '2022-12-31');
    });

    test('setEndFromSelected should update state based on selected items', () {
      final endNotifier = EndNotifier();
      const start = '01/01/2022';
      final selected = [
        EmptyModels.empty<Item>().copyWith(suggestedLendingDuration: 7),
        EmptyModels.empty<Item>().copyWith(suggestedLendingDuration: 14),
        EmptyModels.empty<Item>().copyWith(suggestedLendingDuration: 21),
      ];
      endNotifier.setEndFromSelected(start, selected);
      expect(endNotifier.state, '08/01/2022');
    });

    test('resetEnd should reset state', () {
      final endNotifier = EndNotifier();
      endNotifier.setEnd('2022-12-31');
      endNotifier.setEnd('');
      expect(endNotifier.state, '');
    });
  });
}
