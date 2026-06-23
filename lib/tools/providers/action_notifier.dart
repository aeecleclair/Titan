import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/exception.dart';

abstract class ActionNotifier extends StateNotifier<AsyncValue<void>> {
  ActionNotifier() : super(const AsyncValue.data(null));

  Future<bool> runBool(
    Future<bool> Function() action, {
    bool showLoading = false,
  }) async {
    if (showLoading) state = const AsyncValue.loading();
    try {
      final result = await action();
      if (showLoading) state = const AsyncValue.data(null);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      if (error is AppException && error.type == ErrorType.tokenExpire) {
        rethrow;
      }
      return false;
    }
  }

  Future<T?> run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      if (error is AppException && error.type == ErrorType.tokenExpire) {
        rethrow;
      }
      return null;
    }
  }
}
