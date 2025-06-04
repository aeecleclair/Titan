import 'package:flutter_riverpod/flutter_riverpod.dart';

final payAmountProvider = StateNotifierProvider<PayAmountProvider, String>((
  ref,
) {
  return PayAmountProvider();
});

class PayAmountProvider extends StateNotifier<String> {
  PayAmountProvider() : super('');

  int _cents = 0;

  void addDigit(String digit) {
    if (digit.length == 1 && RegExp(r'\d').hasMatch(digit)) {
      if (_cents < 999999) {
        _cents = _cents * 10 + int.parse(digit);
        _updateState();
      }
    }
  }

  void backspace() {
    _cents = _cents ~/ 10;
    _updateState();
  }

  void clear() {
    _cents = 0;
    _updateState();
  }

  double get amount => _cents / 100.0;

  void _updateState() {
    final euros = _cents ~/ 100;
    final cents = _cents % 100;
    state = '$euros,${cents.toString().padLeft(2, '0')}';
  }
}
