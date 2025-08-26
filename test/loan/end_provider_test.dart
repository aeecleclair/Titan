import 'package:flutter_test/flutter_test.dart';
import 'package:titan/loan/providers/end_provider.dart';

void main() {
  group('EndNotifier', () {
    test('setEnd', () {
      final endNotifier = EndNotifier();
      endNotifier.setEnd('2022-12-31');
      expect(endNotifier.state, '2022-12-31');
    });

    // test('setEndFromSelected', () {
    //   final endNotifier = EndNotifier();
    //   const start = '01/01/2022';
    //   final selected = [
    //     Item.empty().copyWith(suggestedLendingDuration: 7),
    //     Item.empty().copyWith(suggestedLendingDuration: 14),
    //     Item.empty().copyWith(suggestedLendingDuration: 21),
    //   ];
    //   endNotifier.setEndFromSelected(start, selected);
    //   expect(endNotifier.state, '08/01/2022');
    // });
  });
}
