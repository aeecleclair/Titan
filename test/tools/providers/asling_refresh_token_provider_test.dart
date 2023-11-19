// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/tools/providers/asking_refresh_token_provider.dart';

void main() {
  test('AskingRefreshTokenNotifier sets state correctly', () {
    final askingRefreshTokenNotifier = AskingRefreshTokenNotifier();

    askingRefreshTokenNotifier.setbool(true);
    expect(askingRefreshTokenNotifier.state, true);

    askingRefreshTokenNotifier.setbool(false);
    expect(askingRefreshTokenNotifier.state, false);
  });

  test('askingRefreshTokenProvider returns correct value', () {
    final container = ProviderContainer();

    container.read(askingRefreshTokenProvider.notifier).setbool(true);
    expect(container.read(askingRefreshTokenProvider), true);

    container.read(askingRefreshTokenProvider.notifier).setbool(false);
    expect(container.read(askingRefreshTokenProvider), false);
  });
}