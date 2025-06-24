import 'package:flutter_test/flutter_test.dart';
import 'package:titan/amap/providers/selected_list_provider.dart';

void main() {
  group('SelectedListProvider', () {
    test(
      'SelectedListProvider toggle should toggle the value at the given index',
      () {
        final provider = SelectedListProvider([1, 2, 3]);
        expect(provider.state, [true, true, true]);
        provider.toggle(1);
        expect(provider.state, [true, false, true]);
      },
    );

    test('SelectedListProvider clear should set all values to true', () {
      final provider = SelectedListProvider([1, 2, 3]);
      provider.toggle(1);
      expect(provider.state, [true, false, true]);
      provider.clear();
      expect(provider.state, [true, true, true]);
    });

    test(
      'SelectedListProvider rebuild should generate a new list of true values',
      () {
        final provider = SelectedListProvider([1, 2, 3]);
        provider.toggle(1);
        expect(provider.state, [true, false, true]);
        provider.rebuild([4, 5, 6]);
        expect(provider.state, [true, true, true]);
      },
    );
  });
}
