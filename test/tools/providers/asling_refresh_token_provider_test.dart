import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/tools/providers/asking_refresh_token_provider.dart';

void main() {
  test('AskingRefreshTokenNotifier sets state correctly', () {
    final askingRefreshTokenNotifier = AskingRefreshTokenNotifier();

    askingRefreshTokenNotifier.setAskingRefresh(true);
    expect(askingRefreshTokenNotifier.state, true);

    askingRefreshTokenNotifier.setAskingRefresh(false);
    expect(askingRefreshTokenNotifier.state, false);
  });

  test('askingRefreshTokenProvider returns correct value', () {
    final container = ProviderContainer();

    container.read(askingRefreshTokenProvider.notifier).setAskingRefresh(true);
    expect(container.read(askingRefreshTokenProvider), true);

    container.read(askingRefreshTokenProvider.notifier).setAskingRefresh(false);
    expect(container.read(askingRefreshTokenProvider), false);
  });
}
